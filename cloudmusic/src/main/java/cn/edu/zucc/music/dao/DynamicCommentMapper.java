package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.DynamicComment;
import org.apache.ibatis.annotations.Mapper;

@Mapper

public interface DynamicCommentMapper {
    int deleteByPrimaryKey(Integer dynamicCommentId);

    int insert(DynamicComment record);

    int insertSelective(DynamicComment record);

    DynamicComment selectByPrimaryKey(Integer dynamicCommentId);

    int updateByPrimaryKeySelective(DynamicComment record);

    int updateByPrimaryKey(DynamicComment record);
}