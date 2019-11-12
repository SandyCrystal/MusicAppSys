package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Follow;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FollowMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Follow record);

    int insertSelective(Follow record);

    Follow selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Follow record);

    int updateByPrimaryKey(Follow record);
}