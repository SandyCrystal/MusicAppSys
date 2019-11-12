package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.DynamicComment;

public interface DynamicCommentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(DynamicComment record);

    int insertSelective(DynamicComment record);

    DynamicComment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(DynamicComment record);

    int updateByPrimaryKey(DynamicComment record);
}