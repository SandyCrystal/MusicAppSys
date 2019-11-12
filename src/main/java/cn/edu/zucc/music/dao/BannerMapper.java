package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Banner;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BannerMapper {
    int insert(Banner record);

    int insertSelective(Banner record);
}