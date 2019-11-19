package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.AlbumComment;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AlbumCommentMapper {
    int deleteByPrimaryKey(Integer albumCommentId);

    int insert(AlbumComment record);

    int insertSelective(AlbumComment record);

    AlbumComment selectByPrimaryKey(Integer albumCommentId);

    int updateByPrimaryKeySelective(AlbumComment record);

    int updateByPrimaryKey(AlbumComment record);
}