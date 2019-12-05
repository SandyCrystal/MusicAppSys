package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Album;
import cn.edu.zucc.music.model.Sheet;
import cn.edu.zucc.music.model.Song;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SongMapper {
    int deleteByPrimaryKey(String songId);

    int insert(Song record);

    int insertSelective(Song record);

    Song selectByPrimaryKey(String songId);

    List<Song> selectSongBySongName(String songName);

    int updateByPrimaryKeySelective(Song record);

    int updateByPrimaryKey(Song record);

    List<Song> selectTenSongs();

    //    Integer getYearSongCount();
    java.lang.Integer getYearSongCount(@Param("start") String start,@Param("end") String end);

    List<Song> getSongByAlbumId(String albumId);
}