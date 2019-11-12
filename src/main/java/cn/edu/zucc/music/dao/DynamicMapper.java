package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Dynamic;

public interface DynamicMapper {
    int deleteByPrimaryKey(Integer dynamicId);

    int insert(Dynamic record);

    int insertSelective(Dynamic record);

    Dynamic selectByPrimaryKey(Integer dynamicId);

    int updateByPrimaryKeySelective(Dynamic record);

    int updateByPrimaryKey(Dynamic record);
}