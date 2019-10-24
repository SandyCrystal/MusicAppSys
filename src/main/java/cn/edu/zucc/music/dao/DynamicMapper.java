package cn.edu.zucc.music.dao;


import cn.edu.zucc.music.model.Dynamic;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DynamicMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Dynamic record);

    int insertSelective(Dynamic record);

    Dynamic selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Dynamic record);

    int updateByPrimaryKey(Dynamic record);
}