package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Like;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper

public interface LikeMapper {
    int deleteByPrimaryKey(Integer likeId);

    int insert(Like record);

    int insertSelective(Like record);

    Like selectByPrimaryKey(Integer likeId);

    int updateByPrimaryKeySelective(Like record);

    int updateByPrimaryKey(Like record);

    List<Like> findMusicCommentByUserId(String user_id);
}