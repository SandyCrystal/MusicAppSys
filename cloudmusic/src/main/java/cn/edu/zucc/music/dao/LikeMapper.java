package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Like;

public interface LikeMapper {
    int deleteByPrimaryKey(Integer likeId);

    int insert(Like record);

    int insertSelective(Like record);

    Like selectByPrimaryKey(Integer likeId);

    int updateByPrimaryKeySelective(Like record);

    int updateByPrimaryKey(Like record);
}