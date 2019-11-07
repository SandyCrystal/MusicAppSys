package cn.edu.zucc.music.service;

import cn.edu.zucc.music.model.SheetSong;

import java.util.List;

public interface SheetSongService {
    int addSheet(SheetSong sheet);
    int deleteSheet(SheetSong sheet);
    int updateSheet(SheetSong sheet);
    SheetSong findById(int id);
    List<SheetSong> findAll();
}
