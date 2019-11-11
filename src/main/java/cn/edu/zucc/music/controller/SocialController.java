package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.service.CommentService;
import cn.edu.zucc.music.service.DynamicService;
import cn.edu.zucc.music.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
@Controller

public class SocialController {
    public CommentService getSongComment;
    public CommentService commentSong;
    public CommentService likeComment;
    public CommentService unlikeComment;

    public DynamicService viewUserDynamic;
    public DynamicService dynamic;
    public DynamicService getDynamic;

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

    // 获取动态
    @GetMapping(value = "/api/getDynamic")
    @ResponseBody
    public String getDynamic() {
        return "还没做";
    }

}
