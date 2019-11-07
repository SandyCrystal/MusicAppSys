package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {

    private UserService login;
    private UserService logup;

    // 登录
    @GetMapping(value = "/api/login")
    @ResponseBody
    public String getLogin() {
        return "还没做";
    }

    // 注册
    @GetMapping(value = "/api/logup")
    @ResponseBody
    public String getLogup() {
        return "还没做";
    }


}