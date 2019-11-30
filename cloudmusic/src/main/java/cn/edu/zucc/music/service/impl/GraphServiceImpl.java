package cn.edu.zucc.music.service.impl;

import cn.edu.zucc.music.entity.AlbumEntityItem;
import cn.edu.zucc.music.entity.ArtistEntityItem;
import cn.edu.zucc.music.entity.SongEntityItem;
import cn.edu.zucc.music.repository.AlbunRepository;
import cn.edu.zucc.music.repository.ArtistRepository;
import cn.edu.zucc.music.repository.SongRepository;
import cn.edu.zucc.music.service.GraphService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class GraphServiceImpl implements GraphService {
    @Autowired
    private SongRepository songRepository;
    @Autowired
    private ArtistRepository artistRepository;
    @Autowired
    private AlbunRepository albunRepository;
    @Override
    public List<ArtistEntityItem> getArtistItem(String name) {
        List<ArtistEntityItem> list=artistRepository.findByArtistName(name);
        for(ArtistEntityItem artist:list){
           List<AlbumEntityItem>albums= albunRepository.findAllByArtistId(artist.getArtistId());
           for(AlbumEntityItem album : albums){
               album.setSongEntityItemList(songRepository.findAllByAlbumId(album.getAlbumId()));
           }
           System.out.println(albums.size());
            artist.setAlbumEntityItemList(albums);
        }
        return list;
    }

    @Override
    public List<AlbumEntityItem> getAlbumItem(String  Id) {
        return null;
    }

    @Override
    public List<SongEntityItem> getSongItem(String name) {
        return null;
    }
}
