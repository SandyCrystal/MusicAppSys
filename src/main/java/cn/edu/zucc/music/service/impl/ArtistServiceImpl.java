package cn.edu.zucc.music.service.impl;

import cn.edu.zucc.music.dao.ArtistMapper;
import cn.edu.zucc.music.model.Artist;
import cn.edu.zucc.music.service.ArtistService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class ArtistServiceImpl implements ArtistService {
    @Resource
    private ArtistMapper artistMapper;
    @Override
    public int addArtist(Artist artist) {
        return 0;
    }

    @Override
    public int deleteArtist(Artist artist) {
        return 0;
    }

    @Override
    public int updateArtist(Artist artist) {
        return 0;
    }

    @Override
    public Artist findById(String id) {
        return null;
    }

    @Override
    public List<Artist> findAll() {
        return null;
    }
}
