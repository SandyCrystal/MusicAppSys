package cn.edu.zucc.music.service;



import cn.edu.zucc.music.model.Dynamic;

import java.util.List;

public interface DynamicService {
    int addDynamic(Dynamic dynamic);
    int deleteDynamic(Dynamic dynamic);
    int updateDynamic(Dynamic comment);
    int getMaxDynamicId();
    Dynamic findById(int id);
    List<Dynamic> findAll();
    List<Dynamic> getMostTenDynamic();
    List<Dynamic> getDynamicByUserId(String user_id);
}
