package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.Until.Result;
import cn.edu.zucc.music.Until.ResultStatus;
import cn.edu.zucc.music.entity.AlbumEntityItem;
import cn.edu.zucc.music.entity.ArtistEntityItem;
import cn.edu.zucc.music.entity.SongEntityItem;
import cn.edu.zucc.music.model.Album;
import cn.edu.zucc.music.model.Artist;
import cn.edu.zucc.music.model.Banner;
import cn.edu.zucc.music.model.User;
import cn.edu.zucc.music.service.BannerService;
import cn.edu.zucc.music.service.GraphService;
import cn.edu.zucc.music.service.UserService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.annotation.JsonAlias;
import org.neo4j.driver.internal.shaded.io.netty.handler.codec.json.JsonObjectDecoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
public class MainController {
    @Autowired
    private UserService userService;
    @Autowired
    private BannerService bannerService;
    @Autowired
    private GraphService graphService;
    // 登录
    @CrossOrigin
    @GetMapping(value = "/api/login")
    @ResponseBody
    public Result<User> getLogin(String userid,String password) {
        System.out.println(1);
        User user=userService.findById(userid);
        System.out.println(user.getUserPwd());
        if (user==null){
            return new Result<>(ResultStatus.USER_NOT_EXISTS);
        }
        if (user.getUserPwd().equals(password))return new Result<>(ResultStatus.SUCCESS,user);
        else
            return new Result<>(ResultStatus.PERMISSION_DENIED);

    }

    // 注册
    @GetMapping(value = "/api/logup")
    @ResponseBody
    public String getLogup() {
        return "还没做";
    }
    @CrossOrigin
    @GetMapping(value = "/api/banner")
    @ResponseBody
    public Result<Banner> getBanners(){
        return new Result(ResultStatus.SUCCESS,bannerService.findAll());
    }
    @GetMapping(value = "/graph")
    @ResponseBody
    public JSONObject getGraph(String name){
        JSONObject object=new JSONObject();
        JSONObject data=new JSONObject();
         List<ArtistEntityItem> list= graphService.getArtistItem(name);
         List<JSONObject> nodes=new ArrayList<>();
         List<JSONObject> edges=new ArrayList<>();
        for (ArtistEntityItem artist:list) {
            JSONObject node=new JSONObject();
            node.put("id",artist.getId().toString());
            node.put("label",artist.getArtistName());
            node.put("class","artist");
            nodes.add(node);
            for (AlbumEntityItem album:artist.getAlbumEntityItemList()){
                JSONObject node2=new JSONObject();
                node2.put("id",album.getId().toString());
                node2.put("label",album.getAlbumName());
                node2.put("class","album");
                nodes.add(node2);
                JSONObject edge=new JSONObject();
                edge.put("source",node.get("id").toString());
                edge.put("target",node2.get("id").toString());
                edges.add(edge);
                for (SongEntityItem song:album.getSongEntityItemList()){
                    JSONObject node3=new JSONObject();
                    node3.put("id",song.getId().toString());
                    node3.put("label",song.getSongName());
                    node3.put("class","song");
                    nodes.add(node3);
                    JSONObject edge2=new JSONObject();
                    edge2.put("source",node2.get("id").toString());
                    edge2.put("target",node3.get("id").toString());
                    edges.add(edge2);
                }
            }
        }
        data.put("nodes",nodes);
        data.put("edges",edges);
        object.put("code",200);
        object.put("data",data);
         return object;
    }
}