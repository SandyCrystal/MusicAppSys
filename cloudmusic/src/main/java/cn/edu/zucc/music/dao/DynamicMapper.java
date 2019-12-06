package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Dynamic;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper

public interface DynamicMapper {
    int deleteByPrimaryKey(Integer dynamicId);

    int insert(Dynamic dynamic);

    int insertSelective(Dynamic record);

    Dynamic selectByPrimaryKey(Integer dynamicId);

    int updateByPrimaryKeySelective(Dynamic record);

    int updateByPrimaryKey(Dynamic record);

    List<Dynamic> getMostTenDynamic();

    List<Dynamic> getDynamicByUserId(String user_id);

    int getMaxDynamicId();
}