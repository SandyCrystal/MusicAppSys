package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.Until.Result;
import cn.edu.zucc.music.Until.ResultStatus;
import cn.edu.zucc.music.model.*;
import cn.edu.zucc.music.service.*;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Controller
public class MusicController {
    @Autowired
    public SheetService sheetService;
    @Autowired
    public SongService songService;
    @Autowired
    public AlbumService albumService;
    @Autowired
    private ArtistService artistService;
    @Autowired
    private SongCommentService songCommentService;
    @Autowired
    private UserService userService;

    // 添加歌曲（收藏） 把歌曲加入歌单
    @GetMapping(value = "/api/addSong")
    @ResponseBody
    public JSONObject addSong(String sheet_id, String song_id) {
        JSONObject jsonObject = new JSONObject();




        return jsonObject;
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

    // 获取类型歌单
    @GetMapping(value = "/api/getSheetByType")
    @ResponseBody
    public String getSheetByType() {
        return "还没做";
    }

    // 获取推荐歌单
    @Cacheable(value = "getSheetByRecommand")
    @GetMapping(value = "/api/recommandSong")
    @ResponseBody
    public JSONObject getSheetByRecommand() {
        JSONObject jsonObject = new JSONObject();
        List<Song> list = new ArrayList<Song>();
        try {
            list = songService.selectTenSongs();
            jsonObject.put("code", 200);
            List<JSONObject> data = new ArrayList<JSONObject>();
            for(Song song : list) {
                Album album = albumService.findById(song.getAlbumId());
                Artist artist = artistService.findById(album.getArtistId());
                JSONObject tmp = PackerController.transformSongToJson(song, album, artist);
                data.add(tmp);
            }

            jsonObject.put("data", data);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jsonObject;
    }

    // 获取对应歌曲的评论
    @GetMapping(value = "/api/getMusicComment")
    @ResponseBody
    public JSONObject getMusicComment(String id) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 200);
        Song song = songService.findById(id);

        jsonObject.put("more", false);

        List<SongComment> songComments = songCommentService.findBySongId(id);
        List<User> users = new ArrayList<User>();
        jsonObject.put("total", songComments.size());
        for(int i = 0; i < songComments.size(); i++) {
            SongComment songComment = songComments.get(i);
            User user = userService.findById(songComment.getUserId());
            users.add(user);
        }
        List<JSONObject> list = PackerController.transformSongCommentToJson(songComments, users);
        jsonObject.put("comments", list);

        return jsonObject;
    }

    @CrossOrigin
    @GetMapping(value = "/api/makeSongComment")
    @ResponseBody
    public JSONObject makeSongComment(String song_id, String user_id, String content) {
        JSONObject json = new JSONObject();
        User user = userService.findById(user_id);
        Song song = songService.findById(song_id);
        SongComment songComment = new SongComment();
        Date date = new Date();

        String id = songCommentService.findMaxSongCommentId();
        String comment_id = String.valueOf(Integer.parseInt(id)+1);

        songComment.setSongCommentId(comment_id);
        songComment.setCommentContent(content);
        songComment.setCommentTime(date);
        songComment.setLikeCount(0);
        songComment.setSongId(song_id);
        songComment.setUserId(user_id);

        songCommentService.addSongComment(songComment);

        if(user==null || song==null) {
            json.put("code", 666);
            json.put("data", null);
        } else {
            json.put("code", 200);
            JSONObject data = PackerController.transformOneSongCommentToJson(user, songComment);
            json.put("data", data);
        }

        return json;
    }
}
