package cn.edu.zucc.advancejava.dao;

import cn.edu.zucc.advancejava.model.Comments;
import org.apache.ibatis.annotations.Mapper;

@Mapper

public interface CommentsMapper {
    int deleteByPrimaryKey(Long commentId);

    int insert(Comments record);

    int insertSelective(Comments record);

    Comments selectByPrimaryKey(Long commentId);

    int updateByPrimaryKeySelective(Comments record);

    int updateByPrimaryKey(Comments record);
}