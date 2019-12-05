package cn.edu.zucc.music.service;



import cn.edu.zucc.music.model.Dynamic;

import java.util.List;

public interface DynamicService {
    int addDynamic(Dynamic comment);
    int deleteDynamic(Dynamic comment);
    int updateDynamic(Dynamic comment);
    Dynamic findById(int id);
    List<Dynamic> findAll();
    List<Dynamic> getMostTenDynamic();
    List<Dynamic> getDynamicByUserId(String user_id);
}
