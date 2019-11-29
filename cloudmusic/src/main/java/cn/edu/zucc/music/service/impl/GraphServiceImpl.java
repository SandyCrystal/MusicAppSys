package cn.edu.zucc.music.service.impl;

import cn.edu.zucc.music.entity.SongEntityItem;
import cn.edu.zucc.music.repository.SongRepository;
import cn.edu.zucc.music.service.GraphService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GraphServiceImpl implements GraphService {
    @Autowired
    private SongRepository songRepository;
    @Override
    public List<SongEntityItem> findAll(){
        return songRepository.findAll();
    }
}
