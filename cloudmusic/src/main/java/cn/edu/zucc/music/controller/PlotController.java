package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.model.Album;
import cn.edu.zucc.music.model.Song;
import cn.edu.zucc.music.service.*;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.neo4j.driver.internal.shaded.io.netty.handler.codec.json.JsonObjectDecoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
public class PlotController {
    @Autowired
    private ArtistService artistService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private SongService songService;
    @Autowired
    private SongCommentService songCommentService;
    @Autowired
    private PlotService plotService;
    @Cacheable(value = "getPerYearSongCount")
    @GetMapping(value = "/getPerYearSongCount")
    @ResponseBody
    public List<JSONObject> getPerYearSongCount(){
        List<JSONObject> data=new ArrayList<>();
        Map<Integer,Integer> map=plotService.getPerYearSongCount();
        for (Map.Entry<Integer,Integer> entry:map.entrySet()){
            JSONObject json=new JSONObject();
            json.put("year",entry.getKey());
            json.put("count",entry.getValue());
            data.add(json);
        }
        return data;
    }
//    @Cacheable(value = "getSongDistributed")
    @GetMapping(value = "/getSongDistributed")
    @ResponseBody
    public List<JSONObject> getSongDistributed(){
        List<JSONObject> data=new ArrayList<>();
        int[] list=plotService.getMusicDistributed();
        String[] ss=new String[]{
                "0-10",
                "11-100",
                "101-1000",
                "1001-5000",
                "5001-10000",
                "10000以上"
        };
        for (int i=0;i<list.length;i++){
            JSONObject json=new JSONObject();
            json.put("musicSizeRange",ss[i]);
            json.put("count",list[i]);
            data.add(json);
        }
        return data;
    }
}
