package cn.edu.zucc.advancejava.dao;

import cn.edu.zucc.advancejava.model.Photo;

public interface PhotoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Photo record);

    int insertSelective(Photo record);

    Photo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Photo record);

    int updateByPrimaryKey(Photo record);
}