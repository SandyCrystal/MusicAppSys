package cn.edu.zucc.advancejava.dao;

import cn.edu.zucc.advancejava.model.Lyrics;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper

public interface LyricsMapper {
    int deleteByPrimaryKey(Long musicId);

    int insert(Lyrics record);

    int insertSelective(Lyrics record);

    Lyrics selectByPrimaryKey(Long musicId);

    int updateByPrimaryKeySelective(Lyrics record);

    int updateByPrimaryKeyWithBLOBs(Lyrics record);
    List<Lyrics> selectAllLyrics();
}