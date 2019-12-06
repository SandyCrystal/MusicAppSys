package cn.edu.zucc.music.dao;

import cn.edu.zucc.music.model.Collection;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper

public interface CollectionMapper {
    int deleteByPrimaryKey(Integer collection);

    int insert(Collection record);

    int insertSelective(Collection record);

    Collection selectByPrimaryKey(Integer collection);

    int updateByPrimaryKeySelective(Collection record);

    int updateByPrimaryKey(Collection record);

    Collection findPrimaryKey(String user_id, String be_collectioned_id);

    List<Collection> getSongsByUserId(String user_id);

    List<Collection> getSheetsByUserId(String user_id);
}