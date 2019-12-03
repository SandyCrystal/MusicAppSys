package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.User;
import com.sun.org.apache.xpath.internal.objects.XString;
import org.apache.ibatis.annotations.Mapper;

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

}