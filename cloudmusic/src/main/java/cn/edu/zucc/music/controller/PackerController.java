package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.model.*;
import cn.edu.zucc.music.service.UserService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

public class PackerController {
    public static JSONObject transformSheetToJson(Sheet sheet,User user) {
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
        json.put("user_type", user.getUserType());
        json.put("avatar_url", user.getAvatarUrl());
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
            JSONObject jsonUser = new JSONObject();

            jsonUser.put("userType", user.getUserType());
            jsonUser.put("userName", user.getUserName());
            jsonUser.put("introduction", user.getIntroduction());
            jsonUser.put("createTime", user.getCreateTime());
            jsonUser.put("userId", user.getUserId());
            jsonUser.put("avatarUrl", user.getAvatarUrl());

            jsonSongComment.put("comment_id", songComment.getSongCommentId());
            jsonSongComment.put("time", songComment.getCommentTime());
            jsonSongComment.put("content", songComment.getCommentContent());
            jsonSongComment.put("likeCount", songComment.getLikeCount());
            jsonSongComment.put("user", jsonUser);

            list.add(jsonSongComment);
        }

        return list;
    }
}