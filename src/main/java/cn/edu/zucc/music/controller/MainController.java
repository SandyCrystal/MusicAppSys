package cn.edu.zucc.music.controller;


import cn.edu.zucc.music.model.AlbumComment;
import cn.edu.zucc.music.model.Sheet;
import cn.edu.zucc.music.model.Song;
import cn.edu.zucc.music.model.User;
import cn.edu.zucc.music.service.AlbumCommentService;
import cn.edu.zucc.music.service.SheetService;
import cn.edu.zucc.music.service.SongService;
import cn.edu.zucc.music.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;


@Controller
public class MainController {
    @Resource
    private SongService userService;
    @CrossOrigin
    @GetMapping(value = "api/getSongs")
    @ResponseBody
    public void getSongs(){
        Song a=userService.findById(1);
        if (a==null)
        System.out.println("a");
    }

}
