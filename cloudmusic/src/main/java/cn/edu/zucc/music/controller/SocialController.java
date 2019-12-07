package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.Until.Result;
import cn.edu.zucc.music.Until.ResultStatus;
import cn.edu.zucc.music.model.Dynamic;
import cn.edu.zucc.music.model.Follow;
import cn.edu.zucc.music.model.Like;
import cn.edu.zucc.music.model.User;
import cn.edu.zucc.music.service.DynamicService;
import cn.edu.zucc.music.service.FollowService;
import cn.edu.zucc.music.service.LikeService;
import cn.edu.zucc.music.service.UserService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller

public class SocialController {

    @Autowired
    private DynamicService dynamicService;
    @Autowired
    private UserService userService;
    @Autowired
    private FollowService followService;
    @Autowired
    private LikeService likeService;


    // 获取歌曲评论
    @GetMapping(value = "/api/getSongComment")
    @ResponseBody
    public String getSongComment() {
        return "还没做";
    }

    // 评论歌曲
    @GetMapping(value = "/api/commentSong")
    @ResponseBody
    public String commentSong() {
        return "还没做";
    }

    // 点赞（动态、音乐评论、音乐、歌单）
    @GetMapping(value = "/api/like")
    @ResponseBody
    public JSONObject like(String userId, String targetId, int type) {
        JSONObject jsonObject = new JSONObject();
        if (type == 1){
            System.out.println("动态 dynamic");

        }else if (type == 2){
            System.out.println("音乐评论 song_comment");
        }else if (type == 3){
            System.out.println("音乐 song");
        }else {
            System.out.println("歌单 sheet");
        }
        likeService.addLike(userId,targetId, type);
        jsonObject.put("code",200);
        jsonObject.put("data","点赞成功");
        return jsonObject;
    }

    // 取消点赞（动态、歌曲、歌单、评论）
    @GetMapping(value = "/api/unlike")
    @ResponseBody
    public JSONObject unlike(String userId, String targetId, int type) {
        JSONObject jsonObject = new JSONObject();
        if (type == 1){
            System.out.println("动态 dynamic");
        }else if (type == 2){
            System.out.println("音乐评论 song_comment");
        }else if (type == 3){
            System.out.println("音乐 song");
        }else {
            System.out.println("歌单 sheet");
        }
        likeService.disLiked(userId,targetId, type);
        jsonObject.put("code",200);
        jsonObject.put("data","点赞成功");
        return jsonObject;
    }

    // 发表动态
    @GetMapping(value = "/api/createDynamic")
    @ResponseBody
    public JSONObject createDynamic(String userId, String content, String picUrl) throws ParseException {
        JSONObject jsonObject = new JSONObject();
        Dynamic dynamic = new Dynamic();
        User user = userService.findById(userId);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sdf.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
        Date date = new Date(); // java.util.Date
        String dateStr = sdf.format(date);
        Date dateSql = sdf.parse(dateStr);

        int maxDynamicId = dynamicService.getMaxDynamicId() + 1;
        dynamic.setDynamicId(maxDynamicId);
        dynamic.setUserId(userId);
        dynamic.setIntroducion(content);
        dynamic.setDynamicPath(picUrl);
        dynamic.setCreateTime(dateSql);
        dynamic.setLikeCount(0);
        int follow=followService.getFollowedUsers(user.getUserId()).size();
        int fans=followService.getFansUsers(user.getUserId()).size();
        dynamicService.addDynamic(dynamic);
        JSONObject tmp = PackerController.transformTheDynamicToJson(dynamic, user,follow,fans);
        jsonObject.put("code", ResultStatus.SUCCESS.value());
        jsonObject.put("data", tmp);
        return jsonObject;
    }

    // 删除动态
    @GetMapping(value = "/api/deleteDynamic")
    @ResponseBody
    public JSONObject deleteDynamic(String  dynamicId) {
        int id=Integer.parseInt(dynamicId);
        JSONObject jsonObject = new JSONObject();
        Dynamic dynamic = dynamicService.findById(id);
        if (dynamic == null){
            jsonObject.put("code", ResultStatus.DYNAMIC_NOT_EXIST.value());
            jsonObject.put("data", ResultStatus.DYNAMIC_NOT_EXIST.getReasonPhrase());
            return jsonObject;
        }else{
            dynamicService.deleteDynamic(dynamic);
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            jsonObject.put("data", "删除成功");
        }

        return jsonObject;
    }

    // 获取热门动态接口
    @CrossOrigin
    @GetMapping(value = "/api/getDynamicData")
    @ResponseBody
    public JSONObject getDynamicData(String user_id) {
        JSONObject jsonObject = new JSONObject();
        List<Follow> follows= followService.getFollowedUsers(user_id);
        List<Like> likes= likeService.findMusicCommentByUserId(user_id,1);
        List<String> likeIds = new ArrayList<String>();
        List<String> followIds = new ArrayList<String>();
        for (Like like : likes){
            likeIds.add(like.getTolikedId());
        }
        for (Follow follow: follows){
            followIds.add(follow.getToUserId());
        }
        List<Dynamic> dynamics = dynamicService.getMostTenDynamic();
        int[] follow=new int[dynamics.size()];
        int[] fans=new int[dynamics.size()];
         List<User> users = new ArrayList<User>();
        for(int i = 0; i < dynamics.size(); i++) {
            Dynamic dynamic = dynamics.get(i);
            User user = userService.findById(dynamic.getUserId());
            follow[i]=followService.getFollowedUsers(user.getUserId()).size();
            fans[i]=followService.getFansUsers(user.getUserId()).size();
            users.add(user);
        }

        List<JSONObject> data = PackerController.transformDynamicToJson(dynamics, users,follow,fans,likeIds,followIds);
        jsonObject.put("code", 200);
        jsonObject.put("data", data);
        jsonObject.put("total", dynamics.size());
        return jsonObject;
    }

    @CrossOrigin
    @GetMapping(value = "/api/getFollowedDynamic")
    @ResponseBody
    public JSONObject getFollowedDynamic(String user_id) {
        JSONObject jsonObject = new JSONObject();
        User user = userService.findById(user_id);
        List<Follow> follows= followService.getFollowedUsers(user_id);
        List<Like> likes= likeService.findMusicCommentByUserId(user_id,1);
        List<String> likeIds = new ArrayList<String>();
        List<String> followIds = new ArrayList<String>();
        for (Like like : likes){
            likeIds.add(like.getTolikedId());
        }
        for (Follow follow: follows){
            followIds.add(follow.getToUserId());
        }
        if(user==null) {
            jsonObject.put("code", 666);
            jsonObject.put("data", null);
        } else {
            List<Follow> followedUserIds = followService.getFollowedUsers(user_id);
            List<Dynamic> dynamics = new ArrayList<Dynamic>();
            List<User> users = new ArrayList<User>();
            for(Follow follow : followedUserIds) {
                String string = follow.getToUserId();
                List<Dynamic> list = dynamicService.getDynamicByUserId(string);
                for (Dynamic dynamic : list) {
                    dynamics.add(dynamic);
                }
            }
            Collections.sort(dynamics, new Comparator<Dynamic>() {
                @Override
                public int compare(Dynamic d1, Dynamic d2) {
                    long diff = d1.getCreateTime().getTime()-d2.getCreateTime().getTime();
                    if(diff>0) {
                        return 1;
                    } else if(diff>0){
                        return -1;
                    }
                    return 0;
                }
            });
            int[] follow=new int[dynamics.size()];
            int[] fans=new int[dynamics.size()];
            for(int i = 0; i < dynamics.size(); i++) {
                Dynamic dynamic = dynamics.get(i);
                User tmpUser = userService.findById(dynamic.getUserId());
                follow[i]=followService.getFollowedUsers(user.getUserId()).size();
                fans[i]=followService.getFansUsers(user.getUserId()).size();
                users.add(tmpUser);
            }
            List<JSONObject> data = PackerController.transformDynamicToJson(dynamics, users,follow,fans,likeIds,followIds);

            jsonObject.put("code", 200);
            jsonObject.put("data", data);
            jsonObject.put("total", dynamics.size());
        }

        return jsonObject;
    }

    @CrossOrigin
    @GetMapping(value = "/api/getPersonalDynamic")
    @ResponseBody
    public JSONObject getPersonalDynamic(String user_id,String cur_user_id) {
        JSONObject jsonObject = new JSONObject();
        User user = userService.findById(user_id);
        List<Follow> follows = followService.getFollowedUsers(cur_user_id);
        Boolean isFollowed=false;
        for(Follow followd : follows) {if (followd.getToUserId().equals(cur_user_id))isFollowed=true;}
        List<Like> likes=likeService.findMusicCommentByUserId(cur_user_id,1);
        List<String> likeIds= new ArrayList<String>();
        for (Like like: likes) {
            likeIds.add(like.getTolikedId());
        }
        if(user==null) {
            jsonObject.put("code", 666);
            jsonObject.put("data", null);
        } else {
            List<Dynamic> dynamics = dynamicService.getDynamicByUserId(user_id);
            int follow=followService.getFollowedUsers(user.getUserId()).size();
            int fans=followService.getFansUsers(user.getUserId()).size();
            boolean isliked=false;
            List<JSONObject> data=PackerController.transformUserDynamicToJson(dynamics,user,follow,fans,isFollowed,likeIds);
            jsonObject.put("code", 200);
            jsonObject.put("data", data);
            jsonObject.put("total", dynamics.size());
        }

        return jsonObject;
    }

}
