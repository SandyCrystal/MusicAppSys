package cn.edu.zucc.music.service;

import cn.edu.zucc.music.model.Collection;

import java.util.List;

public interface CollectionService {
    int addCollection(Collection collection);
    int deleteCollection(Collection collection);
    int updateCollection(Collection collection);
    Collection findById(int id);
    List<Collection> findAll();
    Collection findPrimaryKey(String user_id, String be_collectioned_id);
}
