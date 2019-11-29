package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.Until.Result;
import cn.edu.zucc.music.Until.ResultStatus;
import cn.edu.zucc.music.entity.SongEntityItem;
import cn.edu.zucc.music.model.Banner;
import cn.edu.zucc.music.model.User;
import cn.edu.zucc.music.service.BannerService;
import cn.edu.zucc.music.service.GraphService;
import cn.edu.zucc.music.service.UserService;
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
    public String getLogup() {
        return "还没做";
    }
    @CrossOrigin
    @GetMapping(value = "/api/banner")
    @ResponseBody
    public Result<Banner> getBanners(){
        return new Result(ResultStatus.SUCCESS,bannerService.findAll());
    }
    @GetMapping(value = "/api/ad")
    @ResponseBody
    public List<SongEntityItem> SongEntityItem(){
        return graphService.findAll();
    }
}