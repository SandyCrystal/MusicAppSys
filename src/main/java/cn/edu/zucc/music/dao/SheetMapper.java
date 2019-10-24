package cn.edu.zucc.music.dao;


import cn.edu.zucc.music.model.Sheet;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SheetMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Sheet record);

    int insertSelective(Sheet record);

    Sheet selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Sheet record);

    int updateByPrimaryKey(Sheet record);
}