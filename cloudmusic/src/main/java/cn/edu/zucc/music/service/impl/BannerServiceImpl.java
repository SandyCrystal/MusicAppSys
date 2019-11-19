package cn.edu.zucc.music.service.impl;

import cn.edu.zucc.music.dao.BannerMapper;
import cn.edu.zucc.music.model.Banner;
import cn.edu.zucc.music.service.BannerService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class BannerServiceImpl implements BannerService {
    @Resource
    private BannerMapper bannerMapper;
    @Override
    public int addBanner(Banner banner) {
        return 0;
    }

    @Override
    public int deleteBanner(Banner banner) {
        return 0;
    }

    @Override
    public int updateBanner(Banner banner) {
        return 0;
    }

    @Override
    public Banner findById(int id) {
        return null;
    }

    @Override
    public List<Banner> findAll() {
        return bannerMapper.selectAll();
    }
}
