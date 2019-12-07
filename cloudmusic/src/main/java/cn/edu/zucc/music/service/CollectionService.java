package cn.edu.zucc.music.service;

import cn.edu.zucc.music.model.Collection;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CollectionService {
    int addCollection(Collection collection);
    int deleteCollection(Collection collection);
    int updateCollection(Collection collection);
    Collection findById(int id);
    List<Collection> findAll();
    Collection findPrimaryKey(String user_id, String be_collectioned_id);
    List<Collection> getSongsByUserId(String user_id);
    List<Collection> getSheetsByUserId(String user_id);
}
