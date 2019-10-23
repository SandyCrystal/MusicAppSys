package cn.edu.zucc.advancejava.dao;

import cn.edu.zucc.advancejava.model.SongComment;

public interface SongCommentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SongComment record);

    int insertSelective(SongComment record);

    SongComment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SongComment record);

    int updateByPrimaryKey(SongComment record);
}