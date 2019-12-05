package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.model.Dynamic;
import cn.edu.zucc.music.model.User;
import cn.edu.zucc.music.service.DynamicService;
import cn.edu.zucc.music.service.UserService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller

public class SocialController {

    @Autowired
    private DynamicService dynamicService;
    @Autowired
    private UserService userService;

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

    // 给评论点赞
    @GetMapping(value = "/api/likeComment")
    @ResponseBody
    public String likeComment() {
        return "还没做";
    }

    // 给评论取消点赞
    @GetMapping(value = "/api/unlikeComment")
    @ResponseBody
    public String unlikeComment() {
        return "还没做";
    }

    // 查看个人动态
    @GetMapping(value = "/api/viewUserDynamic")
    @ResponseBody
    public String viewUserDynamic() {
        return "还没做";
    }

    // 发布动态
    @GetMapping(value = "/api/dynamic")
    @ResponseBody
    public String dynamic() {
        return "还没做";
    }

    // 获取热门动态接口
    @CrossOrigin
    @GetMapping(value = "/api/getDynamicData")
    @ResponseBody
    public JSONObject getDynamicData() {
        JSONObject jsonObject = new JSONObject();

        List<Dynamic> dynamics = dynamicService.getMostTenDynamic();
        List<User> users = new ArrayList<User>();
        for(int i = 0; i < dynamics.size(); i++) {
            Dynamic dynamic = dynamics.get(i);
            User user = userService.findById(dynamic.getUserId());
            users.add(user);
        }

        List<JSONObject> data = PackerController.transformDynamicToJson(dynamics, users);
        jsonObject.put("code", 200);
        jsonObject.put("data", data);
        jsonObject.put("total", dynamics.size());
        return jsonObject;
    }

}
