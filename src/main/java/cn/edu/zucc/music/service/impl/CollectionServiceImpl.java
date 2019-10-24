package cn.edu.zucc.music.service.impl;


import cn.edu.zucc.music.dao.CollectionMapper;
import cn.edu.zucc.music.model.Collection;
import cn.edu.zucc.music.service.CollectionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service(value = "CollectionService")
public class CollectionServiceImpl implements CollectionService {
    @Resource
    CollectionMapper collectionMapper;
    @Override
    public int addCollection(Collection collection)
    {
        return collectionMapper.insertSelective(collection);
    }

    @Override
    public int deleteCollection(Collection collection) {
        return 0;
    }

    @Override
    public int updateCollection(Collection collection) {
        return 0;
    }

    @Override
    public Collection findById(int id) {
        return collectionMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Collection> findAll() {
        return null;
    }


}
