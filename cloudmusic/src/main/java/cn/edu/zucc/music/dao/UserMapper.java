package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper

public interface UserMapper {
    int deleteByPrimaryKey(String userId);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String userId);

    User selectByUserName(String userName);

    String findMaxId();

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    int updateByUserName(User userName);
}