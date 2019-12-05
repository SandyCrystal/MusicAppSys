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
    private SheetService sheetService;
    @Autowired
    private SongService songService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private ArtistService artistService;
    @Autowired
    private SongCommentService songCommentService;
    @Autowired
    private UserService userService;
    @Autowired
    private SheetSongService sheetSongService;


    // 添加歌曲（收藏）
    // 把歌曲加入歌单
    @GetMapping(value = "/api/addSong")
    @ResponseBody
    public JSONObject addSong(String sheetId, String songId) {
        JSONObject jsonObject = new JSONObject();
        Sheet sheet = sheetService.findById(sheetId);
        Song song = songService.findById(songId);
        if (sheet == null){
            jsonObject.put("code", ResultStatus.SHEET_NOT_EXIST.value());
            jsonObject.put("data", ResultStatus.SHEET_NOT_EXIST.getReasonPhrase());
            return jsonObject;
        }
        if (song == null){
            jsonObject.put("code", ResultStatus.SONG_NOT_EXIST.value());
            jsonObject.put("data", ResultStatus.SONG_NOT_EXIST.getReasonPhrase());
            return jsonObject;
        }
        SheetSong sheetSong = sheetSongService.findBySheetIdSongId(sheetId, songId);
        if (sheetSong != null){
            jsonObject.put("code", ResultStatus.SHEET_SONG_ALREADY_EXISTS.value());
            jsonObject.put("data", ResultStatus.SHEET_SONG_ALREADY_EXISTS.getReasonPhrase());
            return jsonObject;
        }else {
            SheetSong sheetSongNew = new SheetSong();
            sheetSongNew.setSheetId(sheetId);
            sheetSongNew.setSongId(songId);
            int sheetSongId = sheetSongService.getMaxSheetSongId() + 1;
            sheetSongNew.setSheetSongId(sheetSongId);
            sheetSongService.addSheet(sheetSongNew);
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            jsonObject.put("data", "添加成功");
        }

        return jsonObject;
    }

    // 删除歌单
    // 把歌曲移出歌单
    @GetMapping(value = "/api/delSong")
    @ResponseBody
    public JSONObject delSong(String sheetId, String songId) {
        JSONObject jsonObject = new JSONObject();
        SheetSong sheetSong = sheetSongService.findBySheetIdSongId(sheetId, songId);
        if (sheetSong == null){
            jsonObject.put("code", ResultStatus.SHEET_SONG_NOT_EXIST.value());
            jsonObject.put("data", ResultStatus.SHEET_SONG_NOT_EXIST.getReasonPhrase());
            return jsonObject;
        }else {
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            jsonObject.put("data", 1);
            sheetSongService.deleteSheet(sheetSong);
        }

        return jsonObject;
    }

    // 获得歌曲信息 根据音乐代码获取音乐(用于播放等)
    @GetMapping(value = "/api/getSong")
    @ResponseBody
    public String getSong(String songId) {
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

    //
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
    @Cacheable(value = "getAlbumDetails")
    @CrossOrigin
    @GetMapping(value = "/api/getAlbumDetails")
    @ResponseBody
    public JSONObject getAlbumDetails(String album_id) {
        JSONObject json = new JSONObject();
        Album album = albumService.findById(album_id);
        if(album==null) {
            json.put("code", 666);
            json.put("data", null);
        } else {
            JSONObject jsonData = new JSONObject();
            List<JSONObject> jsonSong = new ArrayList<JSONObject>();
            JSONObject jsonAlbum = new JSONObject();

            jsonAlbum.put("id", album.getAlbumId());
            jsonAlbum.put("name", album.getAlbumName());
            jsonAlbum.put("picUrl", album.getAlbumPicUrl());

            List<Song> songs = songService.getSongByAlbumId(album_id);
            List<Artist> artists = new ArrayList<Artist>();
            for(Song song : songs) {
                Artist artist = artistService.findById(album.getArtistId());
                artists.add(artist);
            }
            jsonSong = PackerController.transformSongsToJson(songs, jsonAlbum, artists);

            jsonData.put("id", album.getAlbumId());
            jsonData.put("name", album.getAlbumName());
            Artist artist = artistService.findById(album.getArtistId());
            jsonData.put("artist", PackerController.transformArtistToJson(artist));
            jsonData.put("picurl", album.getAlbumPicUrl());
            jsonData.put("songs", jsonSong);

            json.put("code", 200);
            json.put("data", jsonData);
        }

        return json;
    }
    @Cacheable(value = "getAlbumList")
    @CrossOrigin
    @GetMapping(value = "/api/getAlbumList")
    @ResponseBody
    public JSONObject getAlbumList() {
        JSONObject json = new JSONObject();

        List<Album> albums = albumService.getTwentyAlbums();
        List<Artist> artists = new ArrayList<Artist>();
        for(Album album : albums) {
            Artist artist = artistService.findById(album.getArtistId());
            artists.add(artist);
        }
        List<JSONObject> data = PackerController.transformAlbumsToJSON(albums, artists);

        json.put("code", 200);
        json.put("data", data);
        json.put("total",data.size());
        return json;
    }
    // 搜索歌曲
    @GetMapping(value = "/api/searchSong")
    @ResponseBody
    public JSONObject searchSong(String keywords) {
        JSONObject jsonObject = new JSONObject();
        List<Song> songs =  songService.searchSongBySongName("%" + keywords + "%");
        if (songs.size()!=0){
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            List<Artist> artists=new ArrayList<>();
            List<Album> albums=new ArrayList<>();
            int len;
            if (songs.size()>10){
                len=10;
            }else len=songs.size();
            for(int i=0;i<len;i++){
                Song song=songs.get(i);
                Album album=albumService.findById(song.getAlbumId());
                albums.add(album);
                artists.add(artistService.findById(album.getArtistId()));
            }
            List<JSONObject> tmp = PackerController.transfromSongsToJson(songs,albums,artists,len);
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
