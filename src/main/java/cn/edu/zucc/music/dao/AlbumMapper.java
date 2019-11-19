package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Album;
import org.apache.ibatis.annotations.Mapper;

@Mapper

public interface AlbumMapper {
    int deleteByPrimaryKey(String albumId);

    int insert(Album record);

    int insertSelective(Album record);

    Album selectByPrimaryKey(String albumId);

    int updateByPrimaryKeySelective(Album record);

    int updateByPrimaryKey(Album record);
}