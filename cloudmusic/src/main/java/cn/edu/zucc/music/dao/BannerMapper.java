package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Banner;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper

public interface BannerMapper {
    int insert(Banner record);

    int insertSelective(Banner record);
    List<Banner> selectAll();
}