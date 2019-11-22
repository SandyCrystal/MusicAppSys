package cn.edu.zucc.music.service;

import cn.edu.zucc.music.model.Sheet;

import java.util.List;

public interface SheetService {
    int addSheet(Sheet sheet);
    int deleteSheet(Sheet sheet);
    int updateSheet(Sheet sheet);
    Sheet findById(String id);
    List<Sheet> findByUserID(String uid);
    List<Sheet> findAll();
    List<Sheet> selectTenSheets();
}
