package cn.edu.zucc.music.service;

import cn.edu.zucc.music.model.Banner;

import java.util.List;

public interface BannerService {
    int addBanner(Banner banner);
    int deleteBanner(Banner banner);
    int updateBanner(Banner banner);
    Banner findById(int id);
    List<Banner> findAll();
}
