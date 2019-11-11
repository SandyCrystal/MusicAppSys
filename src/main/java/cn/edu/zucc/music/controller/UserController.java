package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
@Controller

public class UserController {
    public UserService modifyUser;
    public UserService followUser;
    public UserService unfollowUser;
    public UserService viewFollowUser;

    public SongService searchSong;
    public AlbumService searchAlbum;
    public SheetService searchSheet;

    // 编辑个人资料
    @GetMapping(value = "/api/modifyUser")
    @ResponseBody
    public String modifyUser() {
        return "还没做";
    }

    // 关注用户
    @GetMapping(value = "/api/followUser")
    @ResponseBody
    public String followUser() {
        return "还没做";
    }

    // 取消关注用户
    @GetMapping(value = "/api/unfollowUser")
    @ResponseBody
    public String unfollowUser() {
        return "还没做";
    }

    // 查看已关注用户
    @GetMapping(value = "/api/viewFollowUser")
    @ResponseBody
    public String viewFollowUser() {
        return "还没做";
    }

    // 搜索歌曲
    @GetMapping(value = "/api/searchSong")
    @ResponseBody
    public String searchSong() {
        return "还没做";
    }

    // 搜索歌单
    @GetMapping(value = "/api/searchSheet")
    @ResponseBody
    public String searchSheet() {
        return "还没做";
    }

    // 搜索专辑
    @GetMapping(value = "/api/searchAlbum")
    @ResponseBody
    public String searchAlbum() {
        return "还没做";
    }
}
