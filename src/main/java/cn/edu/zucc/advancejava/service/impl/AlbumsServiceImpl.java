package cn.edu.zucc.advancejava.service.impl;

import cn.edu.zucc.advancejava.dao.AlbumsMapper;
import cn.edu.zucc.advancejava.model.Albums;
import cn.edu.zucc.advancejava.service.AlbumsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service(value = "AlbumsService")
public class AlbumsServiceImpl implements AlbumsService {
    @Autowired
    private AlbumsMapper albumsMapper;
    @Override
    public int addAlbum(Albums album) {
        return albumsMapper.insertSelective(album);
    }

    @Override
    public Albums findAlbum(long albumId) {
        return albumsMapper.selectByPrimaryKey(albumId);
    }
}
