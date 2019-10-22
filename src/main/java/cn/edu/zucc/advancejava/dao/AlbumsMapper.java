package cn.edu.zucc.advancejava.dao;

import cn.edu.zucc.advancejava.model.Albums;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AlbumsMapper {
    int deleteByPrimaryKey(Long albumId);

    int insert(Albums record);

    int insertSelective(Albums record);

    Albums selectByPrimaryKey(Long albumId);

    int updateByPrimaryKeySelective(Albums record);

    int updateByPrimaryKeyWithBLOBs(Albums record);

    int updateByPrimaryKey(Albums record);
}