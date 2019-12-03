package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.Until.Result;
import cn.edu.zucc.music.Until.ResultStatus;
import cn.edu.zucc.music.model.Banner;
import cn.edu.zucc.music.model.User;
import cn.edu.zucc.music.service.BannerService;
import cn.edu.zucc.music.service.GraphService;
import cn.edu.zucc.music.service.UserService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class MainController {
    @Autowired
    private UserService userService;
    @Autowired
    private BannerService bannerService;
    @Autowired
    private GraphService graphService;
    // 登录
    @CrossOrigin
    @GetMapping(value = "/api/login")
    @ResponseBody
    public Result<User> getLogin(String userid,String password) {
        System.out.println(1);
        User user=userService.findById(userid);
        System.out.println(user.getUserPwd());
        if (user==null){
            return new Result<>(ResultStatus.USER_NOT_EXISTS);
        }
        if (user.getUserPwd().equals(password))return new Result<>(ResultStatus.SUCCESS,user);
        else
            return new Result<>(ResultStatus.PERMISSION_DENIED);

    }

    // 注册
    @GetMapping(value = "/api/logup")
    @ResponseBody
    public JSONObject getLogup(String userName, String password, String password2) {
        JSONObject jsonObject = new JSONObject();
        User user = userService.findByName(userName);
        if (user!=null){
            jsonObject.put("code", 401); // 用户已经存在
            jsonObject.put("data", null);
            return jsonObject;
        }
        if (password.equals(password2)==false) {
            jsonObject.put("code", 222); // 密码1 ！= 密码2
            jsonObject.put("data", null);
            return jsonObject;
        }else {
            int maxId = Integer.parseInt(userService.findMaxId());
            String userId = String.valueOf(maxId+1);
            User userNew = new User();
            userNew.setUserId(userId);
            userNew.setUserName(userName);
            userNew.setUserPwd(password);
            userService.addUser(userNew);
            jsonObject.put("code", 200); // SUCCESS
            jsonObject.put("data", userId);
            return jsonObject;
        }
    }

    @GetMapping(value = "/api/findmaxid")
    @ResponseBody
    public JSONObject getLogup() {
        JSONObject jsonObject = new JSONObject();
        String maxId = userService.findMaxId();
        jsonObject.put("code", 200);
        jsonObject.put("data", maxId);
        return jsonObject;
    }

    @CrossOrigin
    @GetMapping(value = "/api/banner")
    @ResponseBody
    public Result<Banner> getBanners(){
        return new Result(ResultStatus.SUCCESS,bannerService.findAll());
    }
}