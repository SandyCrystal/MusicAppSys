package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.Until.*;
import cn.edu.zucc.music.model.*;
import cn.edu.zucc.music.service.*;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller

public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private SongService songService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private SheetService sheetService;
    @Autowired
    private FollowService followService;

    // 编辑个人资料：
    //      可以修改用户个人介绍等信息(除密码外等可修改内容)
    @GetMapping(value = "/api/modifyUser")
    @ResponseBody
    public JSONObject modifyUser(String username, String introduction, String avatar_url) {
        JSONObject jsonObject = new JSONObject();
        User user = userService.findByName(username);
        boolean hasChanged = false;

//        if (user == null){
//            jsonObject.put("code", ResultStatus.USER_NOT_EXISTS.value());
//            jsonObject.put("data", ResultStatus.USER_NOT_EXISTS.getReasonPhrase());
//            return jsonObject;
//        }

        if (user.getIntroduction() == null || user.getIntroduction().equals(introduction) == false){
            user.setIntroduction(introduction);
            hasChanged = true;
        }

        if (user.getAvatarUrl().equals(avatar_url) == false){
            user.setAvatarUrl(avatar_url);
            hasChanged = true;
        }

        if (hasChanged == true){
            userService.updateUser(user);
            int follow=followService.getFollowedUsers(user.getUserId()).size();
            int fans=followService.getFansUsers(user.getUserId()).size();
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            JSONObject tmp = PackerController.transformUserToJson(user,follow,fans);
            jsonObject.put("data", tmp);
        }else{
            jsonObject.put("code", ResultStatus.USER_INFO_NOT_CHANGED.value());
            jsonObject.put("data", ResultStatus.USER_INFO_NOT_CHANGED.getReasonPhrase());
        }

        return jsonObject;
    }

    // 修改密码
    @GetMapping(value = "/api/modifyPwd")
    @ResponseBody
    public JSONObject modifyPwd(String username, String pwdOld, String pwdNew) {
        JSONObject jsonObject = new JSONObject();
        User user = userService.findByName(username);
        boolean hasChanged = false;

        if (user == null){
            jsonObject.put("code", ResultStatus.USER_NOT_EXISTS.value());
            jsonObject.put("data", ResultStatus.USER_NOT_EXISTS.getReasonPhrase());
            return jsonObject;
        }

        String pwdOldMd5 = MD5Util.getMD5(pwdOld);
        String pwdNewMd5 = MD5Util.getMD5(pwdNew);

        if (user.getUserPwd().equals(pwdOldMd5) == false){ // 原始密码错误
            jsonObject.put("code", ResultStatus.USER_PWD_COMFIRM_ERROR.value());
            jsonObject.put("data", ResultStatus.USER_PWD_COMFIRM_ERROR.getReasonPhrase());
            return jsonObject;
        }

        if (pwdOld.equals(pwdNew) == false){
            hasChanged = true;
            user.setUserPwd(pwdNewMd5);
        }

        if (hasChanged == true){
            userService.updateUser(user);
            int follow=followService.getFollowedUsers(user.getUserId()).size();
            int fans=followService.getFansUsers(user.getUserId()).size();
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            JSONObject tmp = PackerController.transformUserToJson(user,follow,fans);
            jsonObject.put("data", tmp);
        }else {
            jsonObject.put("code", ResultStatus.USER_INFO_NOT_CHANGED.value());
            jsonObject.put("data", ResultStatus.USER_INFO_NOT_CHANGED.value());
        }

        return jsonObject;
    }

    // 上传图片
    @GetMapping(value = "/api/uploadPic")
    @ResponseBody
    public JSONObject uploadPic(String filepath){
        JSONObject jsonObject = new JSONObject();

        Map textMap = new HashMap<String, String>();
        Map fileMap = new HashMap<String, String>();
        String url = "https://sm.ms/api/upload";
        fileMap.put("smfile", filepath);
        String str = HttpRequestUtil.formUpload(url, textMap, fileMap);
        org.json.simple.JSONObject res = JsonUtil.stringToJson(str);
        String code = (String) res.get("code");
        String picURL = new String();

        if (code == null){
            jsonObject.put("code", ResultStatus.UPLOAD_PIC_ERROR.value());
            jsonObject.put("data", ResultStatus.UPLOAD_PIC_ERROR.getReasonPhrase());
            return jsonObject;
        } else if (code.equals("success")){
            org.json.simple.JSONObject data = (org.json.simple.JSONObject) res.get("data");
            picURL = (String) data.get("url");
        }else if (code.equals("image_repeated")){
            picURL = (String) res.get("images");
        }else{
            jsonObject.put("code", ResultStatus.UPLOAD_PIC_ERROR.value());
            jsonObject.put("data", ResultStatus.UPLOAD_PIC_ERROR.getReasonPhrase());
            return jsonObject;
        }

        JSONObject tmp = PackerController.transformPicUrl(picURL);

        jsonObject.put("code", ResultStatus.SUCCESS.value());
        jsonObject.put("data", tmp);
        return jsonObject;
    }

    // 关注用户
    @GetMapping(value = "/api/followUser")
    @ResponseBody
    public JSONObject followUser(String fromUserId, String toUserId) {
        JSONObject jsonObject = new JSONObject();
        Follow follow = followService.getFromMutual(fromUserId, toUserId);
        if (follow != null){
            jsonObject.put("code", ResultStatus.USER_ALREADY_FOLLOW_THIS_USER.value());
            jsonObject.put("data", ResultStatus.USER_ALREADY_FOLLOW_THIS_USER.getReasonPhrase());
            return jsonObject;
        }else {
            int followId = followService.getMaxFollowId()+1;
            Follow newFollow = new Follow();
            newFollow.setFollowId(followId);
            newFollow.setFromUserId(fromUserId);
            newFollow.setToUserId(toUserId);
            followService.addFollow(newFollow);
            JSONObject tmp = PackerController.transfromFollowToJson(newFollow);
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            jsonObject.put("data", tmp);
        }

        return jsonObject;
    }

    // 取消关注用户
    @GetMapping(value = "/api/unfollowUser")
    @ResponseBody
    public JSONObject unfollowUser(String fromUserId, String toUserId) {
        JSONObject jsonObject = new JSONObject();
        Follow follow = followService.getFromMutual(fromUserId, toUserId);
        if (follow == null){
            jsonObject.put("code", ResultStatus.USER_NOT_FOLLOW_THIS_USER.value());
            jsonObject.put("data", ResultStatus.USER_NOT_FOLLOW_THIS_USER.getReasonPhrase());
            return jsonObject;
        }else {
            followService.deleteFollow(follow);
            JSONObject tmp = PackerController.transfromFollowToJson(follow);
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            jsonObject.put("data", tmp);
        }
        return jsonObject;
    }

    // 获取用户关注列表
    @GetMapping(value = "/api/getFollowed")
    @ResponseBody
    public JSONObject getFollowed(String fromUserId) {
        JSONObject jsonObject = new JSONObject();
        List<Follow> follows = followService.getFollowedUsers(fromUserId);
        if (follows.size()==0){
            jsonObject.put("code", ResultStatus.USER_NEVER_FOLLOW.value());
            jsonObject.put("data", ResultStatus.USER_NEVER_FOLLOW.getReasonPhrase());
            return jsonObject;
        }else{
            List<User> users = new ArrayList<>();
            List<Boolean> isMutuals = new ArrayList<>();
            for (Follow follow: follows) {
                String userid = follow.getToUserId();
                Follow mutual = followService.getFromMutual(follow.getToUserId(), follow.getFromUserId());
                if (mutual == null){
                    isMutuals.add(Boolean.FALSE);
                }else {
                    isMutuals.add(Boolean.TRUE);
                }
                User user = userService.findById(userid);
                users.add(user);
            }
            List<JSONObject> data = PackerController.transfromUsersToJson(users, isMutuals);

            jsonObject.put("code", ResultStatus.SUCCESS.value());
            jsonObject.put("data", data);
            jsonObject.put("total", users.size());
        }

        return jsonObject;
    }

    // 查看粉丝列表（已关注用户）
    @GetMapping(value = "/api/getFans")
    @ResponseBody
    public JSONObject getFans(String toUserId) {
        JSONObject jsonObject = new JSONObject();
        List<Follow> follows = followService.getFansUsers(toUserId);
        if (follows.size()==0){
            jsonObject.put("code", ResultStatus.USER_NEVER_BE_FOLLOWED.value());
            jsonObject.put("data", ResultStatus.USER_NEVER_BE_FOLLOWED.getReasonPhrase());
            return jsonObject;
        }else{
            List<User> users = new ArrayList<>();
            List<Boolean> isMutuals = new ArrayList<>();
            for (Follow follow: follows) {
                String userid = follow.getFromUserId();
                Follow mutual = followService.getFromMutual(follow.getToUserId(), follow.getFromUserId());
                if (mutual == null){
                    isMutuals.add(Boolean.FALSE);
                }else {
                    isMutuals.add(Boolean.TRUE);
                }
                User user = userService.findById(userid);
                users.add(user);
            }
            List<JSONObject> data = PackerController.transfromUsersToJson(users, isMutuals);

            jsonObject.put("code", ResultStatus.SUCCESS.value());
            jsonObject.put("data", data);
            jsonObject.put("total", users.size());
        }
        return jsonObject;
    }
}
