package cn.edu.zucc.music.service;

import cn.edu.zucc.music.entity.AlbumEntityItem;
import cn.edu.zucc.music.entity.ArtistEntityItem;
import cn.edu.zucc.music.entity.SongEntityItem;
import com.alibaba.fastjson.JSONObject;

import java.util.List;

public interface GraphService {
    public List<ArtistEntityItem>getArtistItem(String name);
    public List<AlbumEntityItem> getAlbumItem(String  Id) ;
    public List<SongEntityItem>getSongItem(String name);
}
