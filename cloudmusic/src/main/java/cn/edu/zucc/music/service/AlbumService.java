package cn.edu.zucc.music.service;


import cn.edu.zucc.music.model.Album;
import cn.edu.zucc.music.model.Sheet;

import java.util.List;

public interface AlbumService {
    int addAlbum(Album album);
    int deleteAlbum(Album album);
    int updateAlbum(Album album);
    Album findById(String id);
    List<Album> findAll();
    List<Album> searchAlbumByAlbumName(String albumName);
    List<Album> getTwentyAlbums();
}
