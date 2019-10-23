package cn.edu.zucc.advancejava.dao;

import cn.edu.zucc.advancejava.model.Dynamic;

public interface DynamicMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Dynamic record);

    int insertSelective(Dynamic record);

    Dynamic selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Dynamic record);

    int updateByPrimaryKey(Dynamic record);
}