package cn.edu.zucc.music.service;

import cn.edu.zucc.music.entity.*;
import com.alibaba.fastjson.JSONObject;

import java.util.List;

public interface GraphService {
    List<ArtistEntityItem>getArtistItem(String name);
    List<AlbumEntityItem> getAlbumItem(String  Id) ;
    List<AlbumEntityItem> getAlbumItemByname(String name);
    List<SongEntityItem> getSongByname(String name);
    List<SongEntityItem>getSongItem(String id);
    List<ArtistEntityItem> getArtItemByAlb(String id);
    List<SongCommentEntityItem> getCommentsBySongId(String id);
    List<AlbumEntityItem> getAlbumItemBySong(String  Id) ;
    List<UserEntityItem> getUserByComment(String id);
    List<SongCommentEntityItem> getCommentByUser(String id);
    List<SongEntityItem> getSongByComment(String id);
}
