package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper

public interface UserMapper {
    int deleteByPrimaryKey(String userId);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String userId);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
}