package cn.edu.zucc.music.service.impl;


import cn.edu.zucc.music.dao.DynamicCommentMapper;
import cn.edu.zucc.music.model.DynamicComment;
import cn.edu.zucc.music.service.DynamicCommentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class DynamicCommentServiceImpl implements DynamicCommentService {
    @Resource
    private DynamicCommentMapper dynamicCommentMapper;
    @Override
    public int addDynamicComment(DynamicComment comment) {
        return 0;
    }

    @Override
    public int deleteDynamicComment(DynamicComment comment) {
        return 0;
    }

    @Override
    public int updateDynamicComment(DynamicComment comment) {
        return 0;
    }

    @Override
    public DynamicComment findById(int id) {
        return dynamicCommentMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<DynamicComment> findAll() {
        return null;
    }
}
