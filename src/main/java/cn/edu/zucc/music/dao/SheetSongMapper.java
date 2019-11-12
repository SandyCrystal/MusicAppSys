package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.SheetSong;

public interface SheetSongMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SheetSong record);

    int insertSelective(SheetSong record);

    SheetSong selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SheetSong record);

    int updateByPrimaryKey(SheetSong record);
}