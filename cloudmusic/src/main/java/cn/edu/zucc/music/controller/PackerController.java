package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.model.*;
import cn.edu.zucc.music.service.AlbumService;
import cn.edu.zucc.music.service.SheetSongService;
import cn.edu.zucc.music.service.UserService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

public class PackerController {
    @Autowired
    private SheetSongService sheetSongService;
    @Autowired
    private UserService userService;

    public static JSONObject transformSheetToJson(Sheet sheet, User user) {
        JSONObject json = new JSONObject();
        json.put("id", sheet.getSheetId());
        json.put("name", sheet.getSheetName());
        json.put("picUrl", sheet.getSheetPicUrl());
        json.put("playCount", sheet.getPlayCount());
        json.put("createTime", sheet.getCreateTime().getTime());

        try {
            JSONObject tmp = PackerController.transformUserToJson(user);
            json.put("creator", tmp);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    public static JSONObject transformUserToJson(User user) {
        JSONObject json = new JSONObject();
        json.put("user_id", user.getUserId());
        json.put("user_name", user.getUserName());
        json.put("avatar_url", user.getAvatarUrl());
        json.put("user_type", user.getUserType());
        if (user.getCreateTime()==null) json.put("create_time", null);
        else
            json.put("create_time", user.getCreateTime().getTime());
        json.put("introduction", user.getIntroduction());
        return json;
    }

    public static JSONObject transformSongToJson(Song song, Album album, Artist artist) {
        JSONObject json = new JSONObject();
        JSONObject tmp = new JSONObject();

        tmp.put("id", album.getAlbumId());
        tmp.put("name", album.getAlbumName());
        tmp.put("picUrl", album.getAlbumPicUrl());

        json.put("id", song.getSongId());
        json.put("name", song.getSongName());
        if (artist==null)json.put("artist", null);
        else
            json.put("artist", artist.getArtistName());
        json.put("album", tmp);

        return json;
    }

    public static JSONObject transformSheetDetailsToJson(Sheet sheet, User user, List<Song> songs, List<Album> albums) {
        JSONObject json = new JSONObject();
        JSONObject jsonUser = new JSONObject();
        List<JSONObject> list = new ArrayList<JSONObject>();

        jsonUser.put("user_id", user.getUserId());
        jsonUser.put("user_name", user.getUserName());
        jsonUser.put("user_type", user.getUserType());
        jsonUser.put("avatar_url", user.getAvatarUrl());
        jsonUser.put("introduction", user.getIntroduction());

        for (int i = 0; i < songs.size(); i++) {
            Song song = songs.get(i);
            Album album = albums.get(i);
            JSONObject jsonSong = new JSONObject();
            JSONObject jsonAlbum = new JSONObject();

            jsonAlbum.put("id", album.getAlbumId());
            jsonAlbum.put("name", album.getAlbumName());
            jsonAlbum.put("picUrl", album.getAlbumPicUrl());

            jsonSong.put("id", song.getSongId());
            jsonSong.put("name", song.getSongName());
            jsonSong.put("artist", song.getArtistId());
            jsonSong.put("album", jsonAlbum);

            list.add(jsonSong);
        }

        json.put("id", sheet.getSheetId());
        json.put("name", sheet.getSheetName());
        json.put("creator", jsonUser);
        json.put("picUrl", sheet.getSheetPicUrl());
        json.put("playCount", sheet.getPlayCount());
        json.put("subCount", 0);
        json.put("tracks", list);

        return json;
    }

    public static List<JSONObject> transformSongCommentToJson(List<SongComment> songComments, List<User> users) {
        JSONObject json = new JSONObject();
        List<JSONObject> list = new ArrayList<JSONObject>();
        for(int i = 0; i < songComments.size(); i++) {
            SongComment songComment = songComments.get(i);
            User user = users.get(i);
            JSONObject jsonSongComment = new JSONObject();
            if (user==null) jsonSongComment.put("user", null);
            else{
            JSONObject jsonUser = new JSONObject();

            if (user.getUserType()==null) jsonUser.put("userType",0);
            else
                jsonUser.put("userType", user.getUserType());
            jsonUser.put("userName", user.getUserName());
            jsonUser.put("introduction", user.getIntroduction());
                if (user.getCreateTime()==null) json.put("create_time", null);
                else
                    json.put("create_time", user.getCreateTime().getTime());
            jsonUser.put("userId", user.getUserId());
            jsonUser.put("avatarUrl", user.getAvatarUrl());

            jsonSongComment.put("comment_id", songComment.getSongCommentId());
            jsonSongComment.put("time", songComment.getCommentTime().getTime());
            jsonSongComment.put("content", songComment.getCommentContent());
            jsonSongComment.put("likeCount", songComment.getLikeCount());
            jsonSongComment.put("user", jsonUser);}

            list.add(jsonSongComment);
        }

        return list;
    }

    public static List<JSONObject> transformPersonalSheetToJson(List<Sheet> Sheets, User user,int[] trackCount) {
        List<JSONObject> list = new ArrayList<JSONObject>();
        int coun=0;
        for(Sheet sheet : Sheets) {
            JSONObject tmp = new JSONObject();
            tmp.put("id", sheet.getSheetId());
            tmp.put("name", sheet.getSheetName());
            tmp.put("picUrl", sheet.getSheetPicUrl());
            tmp.put("createTime", sheet.getCreateTime().getTime());
            tmp.put("trackCount",trackCount[coun]);
            coun++;
            tmp.put("creator", transformUserToJson(user));
            list.add(tmp);
        }

        return list;
    }

    public static JSONObject transformCreateSheetToJson(User user, Sheet sheet) {
        JSONObject json = new JSONObject();
        json.put("id", sheet.getSheetId());
        json.put("name", sheet.getSheetName());
        json.put("picUrl", sheet.getSheetPicUrl());
        json.put("playCount", sheet.getPlayCount());
        json.put("createTime", sheet.getCreateTime().getTime());
        json.put("creator", transformUserToJson(user));

        return json;
    }

    public static JSONObject transformOneSongCommentToJson(User user, SongComment songComment) {
        JSONObject json = new JSONObject();
        JSONObject jsonComment = new JSONObject();

        jsonComment.put("user", transformUserToJson(user));
        jsonComment.put("comment_id", songComment.getSongCommentId());
        jsonComment.put("content", songComment.getCommentContent());
        jsonComment.put("time", songComment.getCommentTime().getTime());
        jsonComment.put("likeCount", songComment.getLikeCount());


        return jsonComment;
    }


    public static List<JSONObject> transfromSongsToJson(List<Song> songs){
        List<JSONObject> list = new ArrayList<JSONObject>();
        for(Song song : songs) {
            JSONObject tmp = new JSONObject();
            tmp.put("song_id", song.getSongId());
            tmp.put("song_name", song.getSongName());
            tmp.put("album_id", song.getAlbumId());
            tmp.put("artist", song.getArtistId());
            tmp.put("comment_count", song.getCommentCount());
            list.add(tmp);
        }

        return list;
    }

    public static List<JSONObject> transfromSheetsToJson(List<Sheet> sheets){
        List<JSONObject> list = new ArrayList<JSONObject>();
        for(Sheet sheet : sheets) {
            JSONObject tmp = new JSONObject();
            tmp.put("sheet_id", sheet.getSheetId());
            tmp.put("sheet_name", sheet.getSheetName());
            tmp.put("user_id", sheet.getUserId());
            tmp.put("user_name", sheet.getUserName());
            tmp.put("sheet_pic_url", sheet.getSheetPicUrl());
            tmp.put("sheet_type", sheet.getSheetType());
            tmp.put("play_count", sheet.getPlayCount());
            list.add(tmp);
        }

        return list;
    }

    public static List<JSONObject> transfromAlbumsToJson(List<Album> albums){
        List<JSONObject> list = new ArrayList<JSONObject>();
        for(Album album : albums) {
            JSONObject tmp = new JSONObject();
            tmp.put("album_id", album.getAlbumId());
            tmp.put("artist_id", album.getArtistId());
            tmp.put("publish_time", album.getPublishTime());
            tmp.put("album_name", album.getAlbumName());
            tmp.put("introduction", album.getIntroduction());
            tmp.put("album_pic_url", album.getAlbumPicUrl());
            tmp.put("sub_count", album.getShareCount());
            tmp.put("comment_count", album.getCommentCount());
            tmp.put("share_count", album.getShareCount());

            list.add(tmp);
        }

        return list;
    }

    public static JSONObject transformPicUrl(String url) {
        JSONObject json = new JSONObject();
        json.put("url", url);
        return json;
    }

    public static JSONObject transfromSheetSong(SheetSong sheetSong){
        JSONObject json = new JSONObject();
        json.put("sheet_song_id", sheetSong.getSheetSongId());
        json.put("sheet_id", sheetSong.getSheetId());
        json.put("song_id", sheetSong.getSongId());

        return json;
    }

    public static List<JSONObject> transformDynamicToJson(List<Dynamic> dynamics, List<User> users) {
        List<JSONObject> list = new ArrayList<JSONObject>();
        for(int i = 0; i < dynamics.size(); i++) {
            JSONObject json = new JSONObject();
            Dynamic dynamic = dynamics.get(i);
            User user = users.get(i);
            json.put("dynamic_id", dynamic.getDynamicId());
            json.put("content", dynamic.getIntroducion());
            json.put("pic_url", dynamic.getDynamicPath());
            json.put("create_time", dynamic.getCreateTime().toString());
            json.put("like_count", dynamic.getLikeCount());
            json.put("user", transformUserToJson(user));
            list.add(json);
        }

        return list;
    }

    public static JSONObject transformArtistToJson(Artist artist) {
        JSONObject json = new JSONObject();
        json.put("artist_id", artist.getArtistId());
        json.put("artist_name", artist.getArtistName());
        json.put("artist_pic_url", artist.getArtistPicUrl());

        return json;
    }

    public static List<JSONObject> transformSongsToJson(List<Song> songs, JSONObject jsonAlbum, List<Artist> artists) {
        List<JSONObject> json = new ArrayList<JSONObject>();
        for(int i = 0; i < songs.size(); i++) {
            Song song = songs.get(i);
            Artist artist = artists.get(i);
            JSONObject jsonTmp = new JSONObject();
            jsonTmp.put("id", song.getSongId());
            jsonTmp.put("name", song.getSongName());
            jsonTmp.put("artist", artist.getArtistName());
            jsonTmp.put("album", jsonAlbum);
            json.add(jsonTmp);
        }

        return json;
    }
}