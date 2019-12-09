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
    public int addDynamic(Dynamic dynamic) {
        return dynamicMapper.insertSelective(dynamic);
    }

    @Override
    public int deleteDynamic(Dynamic dynamic) {
        return dynamicMapper.deleteByPrimaryKey(dynamic.getDynamicId());
    }

    @Override
    public int updateDynamic(Dynamic comment) {
        return dynamicMapper.updateByPrimaryKey(comment);
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

    @Override
    public List<Dynamic> getDynamicByUserId(String user_id) {
        return dynamicMapper.getDynamicByUserId(user_id);
    }

    @Override
    public int getMaxDynamicId(){
        return dynamicMapper.getMaxDynamicId();
    };
}
