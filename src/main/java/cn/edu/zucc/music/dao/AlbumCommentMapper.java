package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.AlbumComment;

public interface AlbumCommentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(AlbumComment record);

    int insertSelective(AlbumComment record);

    AlbumComment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AlbumComment record);

    int updateByPrimaryKey(AlbumComment record);
}