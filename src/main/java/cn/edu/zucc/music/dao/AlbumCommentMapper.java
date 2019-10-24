package cn.edu.zucc.music.dao;


import cn.edu.zucc.music.model.AlbumComment;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AlbumCommentMapper {
    int insert(AlbumComment record);
    AlbumComment selectByPrimaryKey(Integer id);
    int insertSelective(AlbumComment record);
}