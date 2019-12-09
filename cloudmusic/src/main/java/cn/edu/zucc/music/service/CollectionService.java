package cn.edu.zucc.music.service;

import cn.edu.zucc.music.model.Collection;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CollectionService {
    int addCollection(Collection collection);
    int deleteCollection(Collection collection);
    int updateCollection(Collection collection);
    Collection findById(int id);
    List<Collection> findAll();

    Collection findPrimaryKey(String user_id, String be_collectioned_id, int type);
    List<Collection> getSongsByUserId(String user_id);
    List<Collection> getSheetsByUserId(String user_id);
}
