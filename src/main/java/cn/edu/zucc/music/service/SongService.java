package cn.edu.zucc.music.service;

import cn.edu.zucc.music.model.Song;

import java.util.List;

public interface SongService {
    int addSong(Song song);
    int deleteSong(Song song);
    int updateSong(Song song);
    Song findById(int id);
    List<Song> findAll();
}
