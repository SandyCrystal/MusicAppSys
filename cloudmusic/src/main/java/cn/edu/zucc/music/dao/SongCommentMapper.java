package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.SongComment;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper

public interface SongCommentMapper {
    int deleteByPrimaryKey(String songCommentId);

    int insert(SongComment record);

    int insertSelective(SongComment record);

    SongComment selectByPrimaryKey(String songCommentId);

    int updateByPrimaryKeySelective(SongComment record);

    int updateByPrimaryKey(SongComment record);

    List<SongComment> selectBySongId(String song_id);
}