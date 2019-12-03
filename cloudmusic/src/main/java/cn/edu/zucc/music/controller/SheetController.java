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

    @CrossOrigin
    @GetMapping(value = "/api/createSheet")
    @ResponseBody
    public Result<String > createSheet(String userid, String sheetname ){
        Sheet sheet =new Sheet();
        sheet.setSheetName(sheetname);
        sheet.setUserId(userid);
        int a=sheetService.addSheet(sheet);
        System.out.println(a);
        return new Result<>(ResultStatus.SUCCESS);
    }

    @CrossOrigin
    @GetMapping(value = "/api/recommandSheet")
    @ResponseBody
    public JSONObject recommandSheet() {
        JSONObject jsonObject = new JSONObject();
        List<Sheet> list = new ArrayList<Sheet>();
        try {
            list = sheetService.selectTenSheets();
            jsonObject.put("code", 200);
            List<JSONObject> data = new ArrayList<JSONObject>();
            for(Sheet sheet : list) {
                User user = userService.findById(sheet.getUserId());
                JSONObject tmp = PackerController.transformSheetToJson(sheet,user);
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
    public JSONObject getSheetDetails(String sheet_id){
        JSONObject jsonObject = new JSONObject();

        Sheet sheet = sheetService.findById(sheet_id);

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
            jsonObject.put("code", 200);
            JSONObject tmp = PackerController.transformSheetDetailsToJson(sheet, user, songs, albums);
            jsonObject.put("data", tmp);
        }
        return jsonObject;
    }
}
