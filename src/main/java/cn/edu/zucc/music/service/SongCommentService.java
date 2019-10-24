package cn.edu.zucc.music.service;


import cn.edu.zucc.music.model.SongComment;

import java.util.List;

public interface SongCommentService {
    int addSongComment(SongComment songComment);
    int deleteSongComment(SongComment songComment);
    int updateSongComment(SongComment songComment);
    SongComment findById(int id);
    List<SongComment> findAll();
}
