package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.service.AlbumService;
import cn.edu.zucc.music.service.CommentService;
import cn.edu.zucc.music.service.SheetService;
import cn.edu.zucc.music.service.SongService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

public class MusicController {
    public SheetService addSheet;
    public SheetService delSheet;
    public SheetService getSheetBySheetId;
    public SheetService getSheetByUserId;
    public SheetService getSheetByType;
    public SheetService getSheetByRecommand;

    public SongService addSong;
    public SongService delSong;
    public SongService getSong;

    public AlbumService getAlbum;

    // 创建歌单
    @GetMapping(value = "/api/addSheet")
    @ResponseBody
    public String addSheet() {
        return "还没做";
    }

    // 删除歌单
    @GetMapping(value = "/api/delSheet")
    @ResponseBody
    public String delSheet() {
        return "还没做";
    }

    // 添加歌曲 把歌曲加入歌单
    @GetMapping(value = "/api/addSong")
    @ResponseBody
    public String addSong() {
        return "还没做";
    }

    // 删除歌曲 把歌曲移出歌单
    @GetMapping(value = "/api/delSong")
    @ResponseBody
    public String delSong() {
        return "还没做";
    }

    // 获得歌曲信息 根据音乐代码获取音乐(用于播放等)
    @GetMapping(value = "/api/getSong")
    @ResponseBody
    public String getSong() {
        return "还没做";
    }

    // 获取专辑信息 根据专辑代码获取专辑
    @GetMapping(value = "/api/getAlbum")
    @ResponseBody
    public String getAlbum() {
        return "还没做";
    }

    // 根据歌单代码获取歌单
    @GetMapping(value = "/api/getSheetBySheetId")
    @ResponseBody
    public String getSheetBySheetId() {
        return "还没做";
    }

    // 获取个人歌单
    @GetMapping(value = "/api/getSheetByUserId")
    @ResponseBody
    public String getSheetByUserId() {
        return "还没做";
    }

    // 获取类型歌单
    @GetMapping(value = "/api/getSheetByType")
    @ResponseBody
    public String getSheetByType() {
        return "还没做";
    }

    // 获取推荐歌单
    @GetMapping(value = "/api/getSheetByRecommand")
    @ResponseBody
    public String getSheetByRecommand() {
        return "还没做";
    }


}
