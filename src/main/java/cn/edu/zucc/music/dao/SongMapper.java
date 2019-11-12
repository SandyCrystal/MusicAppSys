package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Song;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SongMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Song record);

    int insertSelective(Song record);

    Song selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Song record);

    int updateByPrimaryKeyWithBLOBs(Song record);

    int updateByPrimaryKey(Song record);
}