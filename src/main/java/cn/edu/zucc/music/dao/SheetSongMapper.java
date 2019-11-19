package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.SheetSong;
import org.apache.ibatis.annotations.Mapper;

@Mapper

public interface SheetSongMapper {
    int deleteByPrimaryKey(Integer sheetSongId);

    int insert(SheetSong record);

    int insertSelective(SheetSong record);

    SheetSong selectByPrimaryKey(Integer sheetSongId);

    int updateByPrimaryKeySelective(SheetSong record);

    int updateByPrimaryKey(SheetSong record);
}