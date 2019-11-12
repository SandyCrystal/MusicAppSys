package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Banner;

public interface BannerMapper {
    int insert(Banner record);

    int insertSelective(Banner record);
}