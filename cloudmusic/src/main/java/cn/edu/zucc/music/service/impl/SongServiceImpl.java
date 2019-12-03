package cn.edu.zucc.music.service.impl;

import cn.edu.zucc.music.dao.SongMapper;
import cn.edu.zucc.music.model.Album;
import cn.edu.zucc.music.model.Sheet;
import cn.edu.zucc.music.model.Song;
import cn.edu.zucc.music.service.SongService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service(value = "songService")
public class SongServiceImpl implements SongService {
    @Resource
    private SongMapper songMapper;
    @Override
    public int addSong(Song song) {
        return 0;
    }

    @Override
    public int deleteSong(Song user) {
        return 0;
    }

    @Override
    public int updateSong(Song user) {
        return 0;
    }

    @Override
    public Song findById(String id) {
        return songMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Song> findAll() {
        return null;
    }

    @Override
    public List<Song> searchSongBySongName(String songName) {
        return songMapper.selectSongBySongName(songName);
    }

    @Override
    public List<Song> selectTenSongs() {
        return songMapper.selectTenSongs();
    }
}
