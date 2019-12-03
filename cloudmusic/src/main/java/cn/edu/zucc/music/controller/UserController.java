package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.Until.MD5Util;
import cn.edu.zucc.music.Until.Result;
import cn.edu.zucc.music.Until.ResultStatus;
import cn.edu.zucc.music.model.Album;
import cn.edu.zucc.music.model.Sheet;
import cn.edu.zucc.music.model.Song;
import cn.edu.zucc.music.model.User;
import cn.edu.zucc.music.service.*;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

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
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            JSONObject tmp = PackerController.transformUserToJson(user);
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
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            JSONObject tmp = PackerController.transformUserToJson(user);
            jsonObject.put("data", tmp);
        }else {
            jsonObject.put("code", ResultStatus.USER_INFO_NOT_CHANGED.value());
            jsonObject.put("data", ResultStatus.USER_INFO_NOT_CHANGED.value());
        }

        return jsonObject;
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
    public JSONObject searchSong(String songName) {
        JSONObject jsonObject = new JSONObject();
        List<Song> songs =  songService.searchSongBySongName("%" + songName + "%");
        if (songs.size()!=0){
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            List<JSONObject> tmp = PackerController.transfromSongsToJson(songs);
            jsonObject.put("data", tmp);
        }else{
            jsonObject.put("code", ResultStatus.SONG_NOT_EXIST.value());
            jsonObject.put("data", ResultStatus.SONG_NOT_EXIST.getReasonPhrase());
        }
        return jsonObject;
    }

    // 搜索歌单
    @GetMapping(value = "/api/searchSheet")
    @ResponseBody
    public JSONObject searchSheet(String sheetName) {
        JSONObject jsonObject = new JSONObject();
        List<Sheet> sheets =  sheetService.searchSheetBySheetName("%" + sheetName + "%");
        if (sheets.size()!=0){
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            List<JSONObject> tmp = PackerController.transfromSheetsToJson(sheets);
            jsonObject.put("data", tmp);
        }else{
            jsonObject.put("code", ResultStatus.SHEET_NOT_EXIST.value());
            jsonObject.put("data", ResultStatus.SHEET_NOT_EXIST.getReasonPhrase());
        }
        return jsonObject;
    }

    // 搜索专辑
    @GetMapping(value = "/api/searchAlbum")
    @ResponseBody
    public JSONObject searchAlbum(String albumName) {
        JSONObject jsonObject = new JSONObject();
        List<Album> albums =  albumService.searchAlbumByAlbumName("%" + albumName + "%");
        if (albums.size()!=0){
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            List<JSONObject> tmp = PackerController.transfromAlbumsToJson(albums);
            jsonObject.put("data", tmp);
        }else{
            jsonObject.put("code", ResultStatus.ALBUM_NOT_EXIST.value());
            jsonObject.put("data", ResultStatus.ALBUM_NOT_EXIST.getReasonPhrase());
        }
        return jsonObject;
    }
}
