package cn.edu.zucc.advancejava.dao;

import cn.edu.zucc.advancejava.model.Sheet;

public interface SheetMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Sheet record);

    int insertSelective(Sheet record);

    Sheet selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Sheet record);

    int updateByPrimaryKey(Sheet record);
}