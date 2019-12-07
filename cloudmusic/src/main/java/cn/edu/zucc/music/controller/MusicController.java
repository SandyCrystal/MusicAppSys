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
    @Autowired
    private CollectionService collectionService;
    @Autowired
    private FollowService followService;
    @Autowired
    private LikeService likeService;

    // 添加歌曲（收藏）
    // 把歌曲加入歌单
    @GetMapping(value = "/api/addSong")
    @ResponseBody
    public JSONObject addSong(String sheetId, String songId) {
        JSONObject jsonObject = new JSONObject();
        Sheet sheet = sheetService.findById(sheetId);
        Song song = songService.findById(songId);
        if (sheet == null) {
            jsonObject.put("code", ResultStatus.SHEET_NOT_EXIST.value());
            jsonObject.put("data", ResultStatus.SHEET_NOT_EXIST.getReasonPhrase());
            return jsonObject;
        }
        if (song == null) {
            jsonObject.put("code", ResultStatus.SONG_NOT_EXIST.value());
            jsonObject.put("data", ResultStatus.SONG_NOT_EXIST.getReasonPhrase());
            return jsonObject;
        }
        SheetSong sheetSong = sheetSongService.findBySheetIdSongId(sheetId, songId);
        if (sheetSong != null) {
            jsonObject.put("code", ResultStatus.SHEET_SONG_ALREADY_EXISTS.value());
            jsonObject.put("data", ResultStatus.SHEET_SONG_ALREADY_EXISTS.getReasonPhrase());
            return jsonObject;
        } else {
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
        if (sheetSong == null) {
            jsonObject.put("code", ResultStatus.SHEET_SONG_NOT_EXIST.value());
            jsonObject.put("data", ResultStatus.SHEET_SONG_NOT_EXIST.getReasonPhrase());
            return jsonObject;
        } else {
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            jsonObject.put("data", 1);
            sheetSongService.deleteSheet(sheetSong);
        }

        return jsonObject;
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
            for (Song song : list) {
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
    public JSONObject getMusicComment(String id, String user_id) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 200);
        List<Follow> follows = followService.getFollowedUsers(user_id);
        List<String> userIds = new ArrayList<String>();
        List<Boolean> isFollowed = new ArrayList<Boolean>();
        List<Like> likes = likeService.findMusicCommentByUserId(user_id);
        List<String> commentIds = new ArrayList<String>();
        List<Boolean> isLiked = new ArrayList<Boolean>();

        for (Follow follow : follows) {
            userIds.add(follow.getToUserId());
        }
        for (Like like : likes) {
            commentIds.add(like.getLikedId());
        }
        jsonObject.put("more", false);

        List<SongComment> songComments = songCommentService.findBySongId(id);
        List<User> users = new ArrayList<User>();
        jsonObject.put("total", songComments.size());
        for (int i = 0; i < songComments.size(); i++) {
            SongComment songComment = songComments.get(i);
            User user = userService.findById(songComment.getUserId());
            users.add(user);
            if(userIds.contains(user.getUserId())) {
                isFollowed.add(true);
            } else {
                isFollowed.add(false);
            }
            if(commentIds.contains(songComment.getSongCommentId())) {
                isLiked.add(true);
            } else {
                isLiked.add(false);
            }
        }
        List<JSONObject> list = PackerController.transformSongCommentToJson(songComments, users, isFollowed, isLiked);
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
        String comment_id = String.valueOf(Integer.parseInt(id) + 1);

        songComment.setSongCommentId(comment_id);
        songComment.setCommentContent(content);
        songComment.setCommentTime(date);
        songComment.setLikeCount(0);
        songComment.setSongId(song_id);
        songComment.setUserId(user_id);

        songCommentService.addSongComment(songComment);

        if (user == null || song == null) {
            json.put("code", 666);
            json.put("data", null);
        } else {
            json.put("code", 200);
            int follow=followService.getFollowedUsers(user.getUserId()).size();
            int fans=followService.getFansUsers(user.getUserId()).size();
            JSONObject data = PackerController.transformOneSongCommentToJson(user, songComment,follow,fans);
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
        if (album == null) {
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
            for (Song song : songs) {
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
        for (Album album : albums) {
            Artist artist = artistService.findById(album.getArtistId());
            artists.add(artist);
        }
        List<JSONObject> data = PackerController.transformAlbumsToJSON(albums, artists);

        json.put("code", 200);
        json.put("data", data);
        json.put("total", data.size());
        return json;
    }

    // 搜索歌曲
    @GetMapping(value = "/api/searchSong")
    @ResponseBody
    public JSONObject searchSong(String keywords, String user_id) {
        JSONObject jsonObject = new JSONObject();
        List<Song> songs = songService.searchSongBySongName("%" + keywords + "%");
        if (songs.size() != 0) {
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            List<Artist> artists = new ArrayList<>();
            List<Album> albums = new ArrayList<>();
            List<Collection> collections = collectionService.getSongsByUserId(user_id);
            List<String> songIds = new ArrayList<String>();
            List<Boolean> isCollectioned = new ArrayList<Boolean>();

            for(Collection collection : collections) {
                songIds.add(collection.getBeCollectionedId());
            }

            int len;
            if (songs.size() > 10) {
                len = 10;
            } else len = songs.size();
            for (int i = 0; i < len; i++) {
                Song song = songs.get(i);
                Album album = albumService.findById(song.getAlbumId());
                albums.add(album);
                artists.add(artistService.findById(album.getArtistId()));
                if(songIds.contains(song.getSongId())) {
                    isCollectioned.add(true);
                } else {
                    isCollectioned.add(false);
                }
            }
            List<JSONObject> tmp = PackerController.transfromSongsToJson(songs, albums, artists, len, isCollectioned);
            jsonObject.put("data", tmp);
        } else {
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
        List<Sheet> sheets = sheetService.searchSheetBySheetName("%" + sheetName + "%");
        if (sheets.size() != 0) {
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            List<JSONObject> tmp = PackerController.transfromSheetsToJson(sheets);
            jsonObject.put("data", tmp);
        } else {
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
        List<Album> albums = albumService.searchAlbumByAlbumName("%" + albumName + "%");
        if (albums.size() != 0) {
            jsonObject.put("code", ResultStatus.SUCCESS.value());
            List<JSONObject> tmp = PackerController.transfromAlbumsToJson(albums);
            jsonObject.put("data", tmp);
        } else {
            jsonObject.put("code", ResultStatus.ALBUM_NOT_EXIST.value());
            jsonObject.put("data", ResultStatus.ALBUM_NOT_EXIST.getReasonPhrase());
        }
        return jsonObject;
    }

    @GetMapping(value = "/api/collection")
    @ResponseBody
    public JSONObject collection(String user_id, String target_id, int type) {
        JSONObject json = new JSONObject();
        int flag = 1;
        User user = userService.findById(user_id);
        if (user == null) {
            flag = 0;
        }
        if (type == 1) {
            Song song = songService.findById(target_id);
            if (song == null) {
                flag = 0;
            }
        } else if (type == 2) {
            Sheet sheet = sheetService.findById(target_id);
            if (sheet == null) {
                flag = 0;
            }
        }
        if (flag == 0) {
            json.put("code", 666);
            JSONObject jsonType = new JSONObject();
            jsonType.put("type", 0);
            json.put("data", jsonType);
        } else {
            Collection collection = collectionService.findPrimaryKey(user_id, target_id);

            if (collection == null) {
                json.put("code", 200);
                JSONObject jsonType = new JSONObject();
                jsonType.put("type", 1);
                json.put("data", jsonType);

                Collection c = new Collection();
                c.setUserId(user_id);
                c.setBeCollectionedId(target_id);
                c.setCollectionType(type);
                collectionService.addCollection(c);
            } else {
                json.put("code", 666);
                JSONObject jsonType = new JSONObject();
                jsonType.put("type", 0);
                json.put("data", jsonType);
            }
        }

        return json;
    }

    @GetMapping(value = "/api/uncollection")
    @ResponseBody
    public JSONObject uncollection(String user_id, String target_id, int type) {
        JSONObject json = new JSONObject();
        int flag = 1;
        User user = userService.findById(user_id);
        if (user == null) {
            flag = 0;
        }
        if (type == 1) {
            Song song = songService.findById(target_id);
            if (song == null) {
                flag = 0;
            }
        } else if (type == 2) {
            Sheet sheet = sheetService.findById(target_id);
            if (sheet == null) {
                flag = 0;
            }
        }
        if (flag == 0) {
            json.put("code", 666);
            JSONObject jsonType = new JSONObject();
            jsonType.put("type", 0);
            json.put("data", jsonType);
        } else {
            Collection collection = collectionService.findPrimaryKey(user_id, target_id);
            if (collection == null) {
                json.put("code", 666);
                JSONObject jsonType = new JSONObject();
                jsonType.put("type", 0);
                json.put("data", jsonType);
            } else {
                json.put("code", 200);
                JSONObject jsonType = new JSONObject();
                jsonType.put("type", 1);
                json.put("data", jsonType);
            }
        }

        return json;
    }

    @GetMapping(value = "/api/getCollectionSong")
    @ResponseBody
    public JSONObject getCollectionSong(String user_id) {
        JSONObject json = new JSONObject();
        List<Collection> collections = collectionService.getSongsByUserId(user_id);
        if(collections == null) {
            json.put("code", 666);
            json.put("data", null);
        } else {
            List<Song> songs = new ArrayList<Song>();
            List<Album> albums = new ArrayList<Album>();
            List<Artist> artists = new ArrayList<Artist>();
            for (Collection collection : collections) {
                Song song = songService.findById(collection.getBeCollectionedId());
                Artist artist = artistService.findById(song.getArtistId());
                Album album = albumService.findById(song.getAlbumId());
                songs.add(song);
                albums.add(album);
                artists.add(artist);
            }
            List<JSONObject> jsonData = PackerController.transformCollectionSongsToJson(songs, albums, artists);
            json.put("code", 200);
            json.put("data", jsonData);
        }

        return json;
    }

    @GetMapping(value = "/api/getCollectionSheet")
    @ResponseBody
    public JSONObject getCollectionSheet(String user_id) {
        JSONObject json = new JSONObject();
        List<Collection> collections = collectionService.getSheetsByUserId(user_id);
        List<Sheet> sheets = new ArrayList<Sheet>();
        List<User> users = new ArrayList<User>();
        int[] follow=new int[collections.size()];
        int[] fans=new int[collections.size()];
        if(collections == null) {
            json.put("code", 666);
            json.put("data", null);
        } else {
            for (int i=0;i<collections.size();i++) {
                Collection collection=collections.get(i);
                Sheet sheet = sheetService.findById(collection.getBeCollectionedId());
                User user = userService.findById(sheet.getUserId());
                follow[i]=followService.getFollowedUsers(user.getUserId()).size();
               fans[i]=followService.getFansUsers(user.getUserId()).size();                sheets.add(sheet);
                users.add(user);
            }

            List<JSONObject> jsonData = PackerController.transformCollectionSheetsToJson(sheets, users,follow,fans);
            json.put("code", 200);
            json.put("data", jsonData);
        }


        return json;
    }
}
