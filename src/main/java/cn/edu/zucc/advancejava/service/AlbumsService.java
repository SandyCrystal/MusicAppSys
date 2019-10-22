package cn.edu.zucc.advancejava.service;

import cn.edu.zucc.advancejava.model.Albums;

public interface AlbumsService {
    int addAlbum(Albums album);
    Albums findAlbum(long AlbumId);
}
