package cn.edu.zucc.music.service.impl;



import cn.edu.zucc.music.dao.SongCommentMapper;
import cn.edu.zucc.music.model.SongComment;
import cn.edu.zucc.music.service.SongCommentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SongCommentServiceImpl implements SongCommentService {
    @Resource
    private SongCommentMapper songCommentMapper;
    @Override
    public int addSongComment(SongComment songComment) {
        return 0;
    }

    @Override
    public int deleteSongComment(SongComment songComment) {
        return 0;
    }

    @Override
    public int updateSongComment(SongComment songComment) {
        return 0;
    }

    @Override
    public SongComment findById(String id) {
        return songCommentMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<SongComment> findAll() {
        return null;
    }

    @Override
    public List<SongComment> findBySongId(String song_id) {
        return songCommentMapper.selectBySongId(song_id);
    }
}
