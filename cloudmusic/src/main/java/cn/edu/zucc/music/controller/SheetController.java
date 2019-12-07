package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.Until.Result;
import cn.edu.zucc.music.Until.ResultStatus;
import cn.edu.zucc.music.model.*;
import cn.edu.zucc.music.service.*;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Controller
public class SheetController {
    @Autowired
    private SheetService sheetService;
    @Autowired
    private UserService userService;
    @Autowired
    private SongService songService;
    @Autowired
    private SheetSongService sheetSongService;
    @Autowired
    private ArtistService artistService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private FollowService followService;
    @Autowired
    private CollectionService collectionService;

    @CrossOrigin
    @GetMapping(value = "/api/createSheet")
    @ResponseBody
    public JSONObject createSheet(String user_id, String sheetname){
        JSONObject jsonObject = new JSONObject();
        User user = userService.findById(user_id);
        Sheet sheet = new Sheet();
        String id = sheetService.findMaxSheetId();
        String sheet_id = String.valueOf(Integer.parseInt(id)+1);
        Date date = new Date();
        sheet.setSheetPicUrl("http://p2.music.126.net/thk687j27THlDlfSP6nJtQ==/19087521858479839.jpg");
        sheet.setSheetId(sheet_id);
        sheet.setSheetName(sheetname);
        sheet.setPlayCount(0);
        sheet.setSheetType(1);
        sheet.setCreateTime(date);
        sheet.setUserId(user_id);
        sheet.setUserName(user.getUserName());
        sheetService.addSheet(sheet);
        int follow=followService.getFollowedUsers(user.getUserId()).size();
        int fans=followService.getFansUsers(user.getUserId()).size();
        List<Follow> follows= followService.getFollowedUsers(user_id);
        jsonObject.put("code", 200);
        Boolean isFollowed=false;
        for(Follow followd : follows) {
            if (followd.getToUserId().equals(user_id))isFollowed=true;
        }
        JSONObject data = PackerController.transformCreateSheetToJson(user, sheet,follow,fans,isFollowed);
        jsonObject.put("data", data);
        return jsonObject;
    }

    @CrossOrigin
    @GetMapping(value = "/api/deleteSheet")
    @ResponseBody
    public JSONObject deleteSheet(String sheet_id) {
        JSONObject jsonObject = new JSONObject();
        Sheet sheet = sheetService.findById(sheet_id);
        if(sheet == null) {
            jsonObject.put("code", 666);
            jsonObject.put("data", "删除失败");
        } else {
            sheetService.deleteSheet(sheet_id);
            jsonObject.put("code", 200);
            jsonObject.put("data", "删除成功");
        }

        return jsonObject;
    }

    @CrossOrigin
    @GetMapping(value = "/api/recommandSheet")
    @ResponseBody
    public JSONObject recommandSheet(String user_id) {
        JSONObject jsonObject = new JSONObject();
        List<Sheet> list = new ArrayList<Sheet>();
        try {
            list = sheetService.selectTenSheets();
            List<Collection> sheetcollections = collectionService.getSheetsByUserId(user_id);
            List<Follow> follows=followService.getFollowedUsers(user_id);
            List<String> sheetIds = new ArrayList<String>();

            for(Collection collection : sheetcollections) {
                sheetIds.add(collection.getBeCollectionedId());
            }
            jsonObject.put("code", 200);
            List<JSONObject> data = new ArrayList<JSONObject>();
            for(Sheet sheet : list) {
                User user = userService.findById(sheet.getUserId());
                int follow=followService.getFollowedUsers(user.getUserId()).size();
                int fans=followService.getFansUsers(user.getUserId()).size();
                boolean isFollowed=false;
                for(Follow followd : follows) {
                    if (followd.getToUserId().equals(user.getUserId()))isFollowed=true;
                }
                boolean isCollectioned=false;
                if (sheetIds.contains(sheet.getSheetId()))isCollectioned=true;
                JSONObject tmp = PackerController.transformSheetToJson(sheet,user,follow,fans,isFollowed,isCollectioned);
                data.add(tmp);
            }

            jsonObject.put("data", data);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jsonObject;
    }

    @CrossOrigin
    @GetMapping(value = "/api/getSheetDetails")
    @ResponseBody
    public JSONObject getSheetDetails(String sheet_id, String user_id ){
        JSONObject jsonObject = new JSONObject();
        Sheet sheet = sheetService.findById(sheet_id);
        boolean sheetisCollected=false;
        List<Boolean> isCollectioned = new ArrayList<Boolean>();
        List<Collection> sheetcollections = collectionService.getSheetsByUserId(user_id);
        List<Collection> songcollections = collectionService.getSongsByUserId(user_id);
        List<String> songIds =new ArrayList<String>();
        for(Collection collection : sheetcollections) {
            if (collection.getBeCollectionedId().equals(sheet_id))sheetisCollected=true;
        }
        if(sheet.getSheetName().equals("") || sheet.getSheetName()==null) {
            jsonObject.put("code", 666);
            jsonObject.put("data", null);
        } else {
            List<SheetSong> sheet_songs = sheetSongService.getSongsBySheetId(sheet_id);
            List<Song> old_songs = new ArrayList<Song>();

            for(SheetSong sheet_song : sheet_songs) {
                Song tmp = songService.findById(sheet_song.getSongId());
                old_songs.add(tmp);
            }
            for(Collection collection : songcollections) {
                songIds.add(collection.getBeCollectionedId());
            }
            List<Song> songs = new ArrayList<Song>();
            List<Album> albums = new ArrayList<Album>();
            User user = userService.findById(sheet.getUserId());
            for(Song song : old_songs) {
                Artist artist = artistService.findById(song.getArtistId());
                song.setArtistId(artist.getArtistName());
                Album album = albumService.findById(song.getAlbumId());
                songs.add(song);
                albums.add(album);
            }

            for(Song song : songs) {
                if(songIds.contains(song.getSongId())) {
                    isCollectioned.add(true);
                } else {
                    isCollectioned.add(false);
                }
            }
            int fans=followService.getFansUsers(user.getUserId()).size();
            List<Follow> follows = followService.getFollowedUsers(user_id);
            int follow=followService.getFollowedUsers(user.getUserId()).size();
            boolean isFollowed=false;
            for(Follow followd : follows) {
                if (followd.getToUserId().equals(user.getUserId()))isFollowed=true;
            }
            jsonObject.put("code", 200);
            JSONObject tmp = PackerController.transformSheetDetailsToJson(sheet, user, songs, albums,sheetisCollected,isCollectioned,follow,fans,isFollowed);
            jsonObject.put("data", tmp);
        }
        return jsonObject;
    }

    @CrossOrigin
    @GetMapping(value = "/api/getPersonalSheet")
    @ResponseBody
    public JSONObject getPersonalSheet(String user_id) {
        JSONObject jsonObject = new JSONObject();
        User user = userService.findById(user_id);
        List<Sheet> list = sheetService.findByUserID(user_id);
        List<Collection> collections = collectionService.getSheetsByUserId(user_id);
        List<String> sheetIds = new ArrayList<String>();
        List<Boolean> isCollectioned = new ArrayList<Boolean>();

        for(Collection collection : collections) {
            sheetIds.add(collection.getBeCollectionedId());
        }
        for(Sheet sheet : list) {
            if(sheetIds.contains(sheet.getSheetId())) {
                isCollectioned.add(true);
            } else {
                isCollectioned.add(false);
            }
        }

        int[] tracksCount=new int[list.size()];
        for (int i=0;i<list.size();i++){
            tracksCount[i]=sheetSongService.getSongsBySheetId(list.get(i).getSheetId()).size();
        }
        if(user.getUserId().equals("") || user.getUserId()==null || list.size()==0) {
            jsonObject.put("code", 666);
            jsonObject.put("data", null);
        } else {

            int follow=followService.getFollowedUsers(user.getUserId()).size();
            int fans=followService.getFansUsers(user.getUserId()).size();
            List<JSONObject> data = PackerController.transformPersonalSheetToJson(list, user,tracksCount,follow,fans, isCollectioned);
            jsonObject.put("code", 200);
            jsonObject.put("data", data);
        }

        return jsonObject;
    }
}
