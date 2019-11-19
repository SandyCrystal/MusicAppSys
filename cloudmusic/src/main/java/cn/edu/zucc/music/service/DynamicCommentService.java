package cn.edu.zucc.music.service;


import cn.edu.zucc.music.model.DynamicComment;

import java.util.List;

public interface DynamicCommentService {
    int addDynamicComment(DynamicComment comment);
    int deleteDynamicComment(DynamicComment comment);
    int updateDynamicComment(DynamicComment comment);
    DynamicComment findById(int id);
    List<DynamicComment> findAll();
}
