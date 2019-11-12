package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Artist;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ArtistMapper {
    int deleteByPrimaryKey(String id);

    int insert(Artist record);

    int insertSelective(Artist record);

    Artist selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Artist record);

    int updateByPrimaryKey(Artist record);
}