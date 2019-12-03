package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Album;
import cn.edu.zucc.music.model.Sheet;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SheetMapper {
    int deleteByPrimaryKey(String sheetId);

    int insert(Sheet record);

    int insertSelective(Sheet record);

    List<Sheet> selectByUserId(String uid);

    Sheet selectByPrimaryKey(String sheetId);

    List<Sheet> selectSheetBySheetName(String sheetName);

    int updateByPrimaryKeySelective(Sheet record);

    int updateByPrimaryKey(Sheet record);

    List<Sheet> selectTenSheets();

    String findMaxSheetId();
}