package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Song;
import org.apache.ibatis.annotations.Mapper;

@Mapper

public interface SongMapper {
    int deleteByPrimaryKey(String songId);

    int insert(Song record);

    int insertSelective(Song record);

    Song selectByPrimaryKey(String songId);

    int updateByPrimaryKeySelective(Song record);

    int updateByPrimaryKey(Song record);
}