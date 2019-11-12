package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Sheet;

public interface SheetMapper {
    int deleteByPrimaryKey(String sheetId);

    int insert(Sheet record);

    int insertSelective(Sheet record);

    Sheet selectByPrimaryKey(String sheetId);

    int updateByPrimaryKeySelective(Sheet record);

    int updateByPrimaryKey(Sheet record);
}