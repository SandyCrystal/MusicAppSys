package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Follow;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper

public interface FollowMapper {
    int deleteByPrimaryKey(Integer followId);

    int insert(Follow record);

    int insertSelective(Follow record);

    Follow selectByPrimaryKey(Integer followId);

    int updateByPrimaryKeySelective(Follow record);

    int updateByPrimaryKey(Follow record);

    List<Follow> getFollowedUsers(String user_id);
}