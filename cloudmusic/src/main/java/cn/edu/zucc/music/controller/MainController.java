package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.Until.MD5Util;
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

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

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
    public Result<User> getLogin(String userid,String pwd_zero) {
        User user=userService.findById(userid);

        String pwd_md5 = MD5Util.getMD5(pwd_zero);

        if (user==null){
            return new Result<>(ResultStatus.USER_NOT_EXISTS);
        }
        if (user.getUserPwd().equals(pwd_md5))return new Result<>(ResultStatus.SUCCESS,user);
        else
            return new Result<>(ResultStatus.PERMISSION_DENIED);

    }

    // 注册
    @GetMapping(value = "/api/logup")
    @ResponseBody
    public JSONObject getLogup(String userName, String pwd1, String pwd2) throws ParseException {
        JSONObject jsonObject = new JSONObject();
        User user = userService.findByName(userName);
        if (user!=null){
            jsonObject.put("code", 401); // 用户已经存在
            jsonObject.put("data", userName);
            return jsonObject;
        }
        if (pwd1.equals(pwd2)==false) {
            jsonObject.put("code", 222); // 密码1 ！= 密码2
            jsonObject.put("data", null);
            return jsonObject;
        }else {
            int maxId = Integer.parseInt(userService.findMaxId());
            String userId = String.valueOf(maxId+1);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            sdf.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
            Date date = new Date(); // java.util.Date
            String dateStr = sdf.format(date);
            Date dateSql = sdf.parse(dateStr);
            String pwd = MD5Util.getMD5(pwd1);

            User userNew = new User();
            userNew.setUserId(userId);
            userNew.setUserName(userName);
            userNew.setUserPwd(pwd);
            userNew.setAvatarUrl("https://i.loli.net/2019/12/03/MpqVU45Hi8JwzY9.jpg"); // 默认头像
            userNew.setUserType(1); // 0-管理员 1-普通用户 2-评论用户
            userNew.setCreateTime(dateSql);


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