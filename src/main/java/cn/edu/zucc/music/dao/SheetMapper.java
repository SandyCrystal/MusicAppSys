package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Sheet;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface SheetMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Sheet record);

    int insertSelective(Sheet record);

    Sheet selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Sheet record);

    int updateByPrimaryKey(Sheet record);
    List<Sheet> selectByUserId(String userid);
}