package cn.edu.zucc.music.service;


import cn.edu.zucc.music.model.Album;

import java.util.List;

public interface AlbumService {
    int addAlbum(Album album);
    int deleteAlbum(Album album);
    int updateAlbum(Album album);
    Album findById(int id);
    List<Album> findAll();
}
