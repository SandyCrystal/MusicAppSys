package cn.edu.zucc.music.service;

import cn.edu.zucc.music.model.Artist;
import org.springframework.stereotype.Service;

import java.util.List;


public interface ArtistService {
    int addArtist(Artist artist);
    int deleteArtist(Artist artist);
    int updateArtist(Artist artist);
    Artist findById(String id);
    List<Artist> findAll();
}
