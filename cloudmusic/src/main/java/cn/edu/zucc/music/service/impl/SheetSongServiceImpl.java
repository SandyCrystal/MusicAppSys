package cn.edu.zucc.music.service.impl;

import cn.edu.zucc.music.dao.SheetSongMapper;
import cn.edu.zucc.music.model.SheetSong;
import cn.edu.zucc.music.model.Song;
import cn.edu.zucc.music.service.SheetSongService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SheetSongServiceImpl implements SheetSongService {
    @Resource
    SheetSongMapper sheetSongMapper;
    @Override
    public int addSheet(SheetSong sheet) {
        return sheetSongMapper.insert(sheet);
    }

    @Override
    public int deleteSheet(SheetSong sheet) {
        return sheetSongMapper.deleteByPrimaryKey(sheet.getSheetSongId());
    }

    @Override
    public int updateSheet(SheetSong sheet) {
        return 0;
    }

    @Override
    public SheetSong findById(int id) {
        return null;
    }

    @Override
    public List<SheetSong> findAll() {
        return null;
    }

    @Override
    public SheetSong findBySheetIdSongId(String sheetId, String songId) {
        return sheetSongMapper.selectBySheetIdSongId(sheetId, songId);
    }

    @Override
    public List<SheetSong> getSongsBySheetId(String sheet_id) {
        return sheetSongMapper.getSongsBySheetId(sheet_id);
    }

    @Override
    public int getMaxSheetSongId(){
        return sheetSongMapper.getMaxSheetSongId();
    }
}
