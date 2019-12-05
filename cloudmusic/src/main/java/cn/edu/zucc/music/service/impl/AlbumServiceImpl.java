package cn.edu.zucc.music.service.impl;

import cn.edu.zucc.music.dao.AlbumMapper;
import cn.edu.zucc.music.model.Album;
import cn.edu.zucc.music.service.AlbumService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service(value = "AlbumService")
public class AlbumServiceImpl implements AlbumService {
    @Resource
    AlbumMapper albumMapper;
    @Override
    public int addAlbum(Album song) {
        return 0;
    }

    @Override
    public int deleteAlbum(Album user) {
        return 0;
    }

    @Override
    public int updateAlbum(Album user) {
        return 0;
    }

    @Override
    public Album findById(String id) {
        return albumMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Album> searchAlbumByAlbumName(String albumName) {
        return albumMapper.selectAlbumByAlbumName(albumName);
    }

    @Override
    public List<Album> findAll() {
        return null;
    }

    @Override
    public List<Album> getTwentyAlbums() {
        return albumMapper.getTwentyAlbums();
    }
}
