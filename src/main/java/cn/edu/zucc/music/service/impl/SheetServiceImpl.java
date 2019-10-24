package cn.edu.zucc.music.service.impl;


import cn.edu.zucc.music.dao.SheetMapper;
import cn.edu.zucc.music.model.Sheet;
import cn.edu.zucc.music.service.SheetService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service(value = "SheetService")
public class SheetServiceImpl implements SheetService {
    @Resource
    SheetMapper sheetMapper;
    @Override
    public Sheet getById(int id) {
        return sheetMapper.selectByPrimaryKey(id) ;
    }
}
