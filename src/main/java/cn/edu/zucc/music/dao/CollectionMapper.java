package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Collection;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CollectionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Collection record);

    int insertSelective(Collection record);

    Collection selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Collection record);

    int updateByPrimaryKey(Collection record);
}