package cn.edu.zucc.advancejava.dao;

import cn.edu.zucc.advancejava.model.Musics;
import org.apache.ibatis.annotations.Mapper;

@Mapper

public interface MusicsMapper {
    int deleteByPrimaryKey(Integer musicId);

    int insert(Musics record);

    int insertSelective(Musics record);

    Musics selectByPrimaryKey(Integer musicId);

    int updateByPrimaryKeySelective(Musics record);

    int updateByPrimaryKey(Musics record);
}