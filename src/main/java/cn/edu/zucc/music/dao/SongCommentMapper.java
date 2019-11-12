package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.SongComment;

public interface SongCommentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SongComment record);

    int insertSelective(SongComment record);

    SongComment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SongComment record);

    int updateByPrimaryKey(SongComment record);
}