package cn.edu.zucc.advancejava.dao;

import cn.edu.zucc.advancejava.model.Artists;
import org.apache.ibatis.annotations.Mapper;

@Mapper

public interface ArtistsMapper {
    int deleteByPrimaryKey(Long artistId);

    int insert(Artists record);

    int insertSelective(Artists record);

    Artists selectByPrimaryKey(Long artistId);

    int updateByPrimaryKeySelective(Artists record);

    int updateByPrimaryKeyWithBLOBs(Artists record);

    int updateByPrimaryKey(Artists record);
}