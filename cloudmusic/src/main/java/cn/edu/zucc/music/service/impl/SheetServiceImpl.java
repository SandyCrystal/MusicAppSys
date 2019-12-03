package cn.edu.zucc.music.service.impl;

import cn.edu.zucc.music.dao.SheetMapper;
import cn.edu.zucc.music.model.Sheet;
import cn.edu.zucc.music.service.SheetService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service(value = "SheetService")
public class SheetServiceImpl implements SheetService {
    @Resource
    SheetMapper sheetMapper;
    @Override
    public int addSheet(Sheet sheet) {
        return sheetMapper.insert(sheet);
    }

    @Override
    public int deleteSheet(String sheet_id) {
        return sheetMapper.deleteByPrimaryKey(sheet_id);
    }

    @Override
    public int updateSheet(Sheet sheet) {
        return 0;
    }

    @Override
    public Sheet findById(String id) {
        return sheetMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Sheet> searchSheetBySheetName(String sheetName) {
        return sheetMapper.selectSheetBySheetName(sheetName);
    }

    @Override
    public List<Sheet> findByUserID(String uid) {
        return sheetMapper.selectByUserId(uid);
    }

    @Override
    public List<Sheet> findAll() {
        return null;
    }

    @Override
    public List<Sheet> selectTenSheets() {
        return sheetMapper.selectTenSheets();
    }

    @Override
    public String findMaxSheetId() {
        return sheetMapper.findMaxSheetId();
    }
}
