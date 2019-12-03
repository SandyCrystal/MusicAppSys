package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.entity.*;
import cn.edu.zucc.music.service.GraphService;
import cn.edu.zucc.music.service.SongCommentService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.awt.*;
import java.util.ArrayList;
import java.util.List;

@Controller
public class GraphController {
    @Autowired
    private GraphService graphService;
    @Autowired
    private SongCommentService songCommentService;
    private static JSONObject getStyle(int type){
        JSONObject style=new JSONObject();
        if (type==1){

        }
        else if (type==1){
            style.put("fill","#FFFF00");
            style.put("stroke","#E8684A");
        }else if (type==2){
            style.put("fill","#3fffff");
            style.put("stroke","#E8684A");
        }else if(type==3) {
            style.put("fill","#f14444");
            style.put("stroke","#E8684A");
        }
        else if(type==4){
            style.put("fill","#4876FF");
            style.put("stroke","#E8684A");
        }
        else {
            style.put("fill","#CDAD00");
            style.put("stroke","#E8684A");
        }

        return style;
    }
    private static JSONObject getNodes(String id,String label,int type,String factId){
        JSONObject node=new JSONObject();
        node.put("id",id);
        node.put("factId",factId);
        node.put("label",label);
        node.put("class",type);
        node.put("style",getStyle(type));
        return node;
    }
    private static JSONObject getEdge(String source,String target ){
        JSONObject edge=new JSONObject();
        edge.put("source",source);
        edge.put("target",target);
        return edge;
    }
//    @Cacheable(value = "getGraph")
    @GetMapping(value = "/graph")
    @ResponseBody
    public JSONObject getGraph(String name){
        JSONObject object=new JSONObject();
        JSONObject data=new JSONObject();
        List<ArtistEntityItem> list= graphService.getArtistItem(name);
        List<JSONObject> nodes=new ArrayList<>();
        List<JSONObject> edges=new ArrayList<>();
        for (ArtistEntityItem artist:list) {
                nodes.add(getNodes(artist.getId().toString(),artist.getArtistName(),1,artist.getArtistId()));
            for (AlbumEntityItem album:artist.getAlbumEntityItemList()){
                nodes.add(getNodes(album.getId().toString(),album.getAlbumName(),2,album.getAlbumId()));
                edges.add(getEdge(artist.getArtistId(),album.getAlbumId()));
                for (SongEntityItem song:album.getSongEntityItemList()){
                    nodes.add(getNodes(song.getId().toString(),song.getSongName(),3,song.getSongId()));
                    edges.add(getEdge(album.getAlbumId(),song.getSongId()));
                }
            }
        }
        data.put("nodes",nodes);
        data.put("edges",edges);
        object.put("code",200);
        object.put("data",data);
        return object;
    }
//  @Cacheable(value = "getArtistNode")
    @GetMapping(value = "/getArtistNode")
    @ResponseBody
    public JSONObject getArtistNode(String name){
        JSONObject object=new JSONObject();
        JSONObject data=new JSONObject();
        List<ArtistEntityItem> list= graphService.getArtistItem(name);
        List<JSONObject> nodes=new ArrayList<>();
        List<JSONObject> edges=new ArrayList<>();
        for (ArtistEntityItem artist:list) {
            nodes.add(getNodes(artist.getId().toString(),artist.getArtistName(),1,artist.getArtistId()));
        }
        data.put("nodes",nodes);
        data.put("edges",edges);
        object.put("code",200);
        object.put("data",data);
        return object;
    }
//    @Cacheable(value = "getAlbumNode")
    @GetMapping(value = "/getAlbumNode")
    @ResponseBody
    public JSONObject getAlbumNode(String name){
        JSONObject object=new JSONObject();
        JSONObject data=new JSONObject();
        List<AlbumEntityItem> list= graphService.getAlbumItemByname(name);
        List<JSONObject> nodes=new ArrayList<>();
        List<JSONObject> edges=new ArrayList<>();
        for (AlbumEntityItem album:list) {
            nodes.add(getNodes(album.getId().toString(),album.getAlbumName(),2,album.getAlbumId()));
        }
        data.put("nodes",nodes);
        data.put("edges",edges);
        object.put("code",200);
        object.put("data",data);
        return object;
    }
//    @Cacheable(value = "getSongNode")
    @GetMapping(value = "/getSongNode")
    @ResponseBody
    public JSONObject getSongNode(String name){
        JSONObject object=new JSONObject();
        JSONObject data=new JSONObject();
        List<SongEntityItem> list= graphService.getSongByname(name);
        List<JSONObject> nodes=new ArrayList<>();
        List<JSONObject> edges=new ArrayList<>();
        for (SongEntityItem song:list) {
            nodes.add(getNodes(song.getId().toString(),song.getSongName(),3,song.getSongId()));
        }
        data.put("nodes",nodes);
        data.put("edges",edges);
        object.put("code",200);
        object.put("data",data);
        return object;
    }
// @Cacheable(value = "dbclickArtist")
    @GetMapping(value = "/dbclickArtist")
    @ResponseBody
    public JSONObject dbclickArtist(String  id,String lid){
        JSONObject object=new JSONObject();
        JSONObject data=new JSONObject();
        List<AlbumEntityItem> list= graphService.getAlbumItem(id);
        List<JSONObject> nodes=new ArrayList<>();
        List<JSONObject> edges=new ArrayList<>();
        for (AlbumEntityItem album:list) {
            nodes.add(getNodes(album.getId().toString(),album.getAlbumName(),2,album.getAlbumId()));
            edges.add(getEdge(lid,album.getId().toString()));
        }
        data.put("nodes",nodes);
        data.put("edges",edges);
        object.put("code",200);
        object.put("data",data);
        return object;
    }
//  @Cacheable(value = "dbclickAlbum")
    @GetMapping(value = "/dbclickAlbum")
    @ResponseBody
    public JSONObject dbclickAlbum(String  id,String lid){
        JSONObject object=new JSONObject();
        JSONObject data=new JSONObject();
        List<SongEntityItem> list= graphService.getSongItem(id);
        List<JSONObject> nodes=new ArrayList<>();
        List<JSONObject> edges=new ArrayList<>();
        for (SongEntityItem song:list) {
            nodes.add(getNodes(song.getId().toString(),song.getSongName(),3,song.getSongId()));
            edges.add(getEdge(lid,song.getId().toString()));
        }
        List<ArtistEntityItem> list1=graphService.getArtItemByAlb(id);
        for (ArtistEntityItem artist:list1) {
            nodes.add(getNodes(artist.getId().toString(),artist.getArtistName(),1,artist.getArtistId()));
            edges.add(getEdge(artist.getId().toString(),lid));
        }
        data.put("nodes",nodes);
        data.put("edges",edges);
        object.put("code",200);
        object.put("data",data);
        return object;
    }
//    @Cacheable(value = "dbclickSong")
    @GetMapping(value = "/dbclickSong")
    @ResponseBody
    public JSONObject dbclickSong(String id,String lid){
        System.out.println(id);
        JSONObject object=new JSONObject();
        JSONObject data=new JSONObject();
        List<SongCommentEntityItem> list= graphService.getCommentsBySongId(id);
        List<JSONObject> nodes=new ArrayList<>();
        List<JSONObject> edges=new ArrayList<>();
        for (SongCommentEntityItem comment:list) {
            nodes.add(getNodes(comment.getId().toString(),songCommentService.findById(comment.getCommentId()).getCommentContent(),4,comment.getCommentId()));
            edges.add(getEdge(lid,comment.getId().toString()));
        }
        List<AlbumEntityItem> list1=graphService.getAlbumItemBySong(id);
        for (AlbumEntityItem album:list1) {
            nodes.add(getNodes(album.getId().toString(),album.getAlbumName(),2,album.getAlbumId()));
            edges.add(getEdge(album.getId().toString(),lid));
        }
        data.put("nodes",nodes);
        data.put("edges",edges);
        object.put("code",200);
        object.put("data",data);
        return object;
    }
//    @Cacheable(value = "dbclickUser")
    @GetMapping(value = "/dbclickUser")
    @ResponseBody
    public JSONObject dbclickUser(String id,String lid){
        JSONObject object=new JSONObject();
        JSONObject data=new JSONObject();
        List<SongCommentEntityItem> list= graphService.getCommentByUser(id);
        List<JSONObject> nodes=new ArrayList<>();
        List<JSONObject> edges=new ArrayList<>();
        for (SongCommentEntityItem comment:list) {
            nodes.add(getNodes(comment.getId().toString(),songCommentService.findById(comment.getCommentId()).getCommentContent(),4,comment.getCommentId()));
            edges.add(getEdge(lid,comment.getId().toString()));
        }
        data.put("nodes",nodes);
        data.put("edges",edges);
        object.put("code",200);
        object.put("data",data);
        return object;
    }
//    @Cacheable(value = "dbclickComment")
    @GetMapping(value = "/dbclickComment")
    @ResponseBody
    public JSONObject dbclickComment(String id,String lid){
        JSONObject object=new JSONObject();
        JSONObject data=new JSONObject();
        List<SongEntityItem> list= graphService.getSongByComment(id);
        List<JSONObject> nodes=new ArrayList<>();
        List<JSONObject> edges=new ArrayList<>();
        for (SongEntityItem song:list) {
            nodes.add(getNodes(song.getId().toString(),song.getSongName(),3,song.getSongId()));
            edges.add(getEdge(song.getId().toString(),lid));
        }
        List<UserEntityItem> list1=graphService.getUserByComment(id);
        for (UserEntityItem user:list1) {
            nodes.add(getNodes(user.getId().toString(),user.getUserName(),5,user.getUserId()));
            edges.add(getEdge(user.getId().toString(),lid));
        }
        data.put("nodes",nodes);
        data.put("edges",edges);
        object.put("code",200);
        object.put("data",data);
        return object;
    }
}
