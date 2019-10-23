package cn.edu.zucc.advancejava.dao;

import cn.edu.zucc.advancejava.model.AlbumComment;

public interface AlbumCommentMapper {
    int insert(AlbumComment record);

    int insertSelective(AlbumComment record);
}