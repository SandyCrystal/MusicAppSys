package cn.edu.zucc.music.service.impl;


import cn.edu.zucc.music.dao.DynamicMapper;
import cn.edu.zucc.music.model.Dynamic;
import cn.edu.zucc.music.service.DynamicService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class DynamicServiceImpl implements DynamicService {
    @Resource
    private DynamicMapper dynamicMapper;
    @Override
    public int addDynamic(Dynamic comment) {
        return 0;
    }

    @Override
    public int deleteDynamic(Dynamic comment) {
        return 0;
    }

    @Override
    public int updateDynamic(Dynamic comment) {
        return 0;
    }

    @Override
    public Dynamic findById(int id) {
        return dynamicMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Dynamic> findAll() {
        return null;
    }

    @Override
    public List<Dynamic> getMostTenDynamic() {
        return dynamicMapper.getMostTenDynamic();
    }
}
