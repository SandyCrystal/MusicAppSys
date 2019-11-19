package cn.edu.zucc.music.service.impl;


import cn.edu.zucc.music.dao.AlbumCommentMapper;
import cn.edu.zucc.music.model.AlbumComment;
import cn.edu.zucc.music.service.AlbumCommentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AlbumCommentServiceImpl implements AlbumCommentService {
    @Resource
    private AlbumCommentMapper albumCommentMapper;

    @Override
    public AlbumComment getById(int id) {
        return albumCommentMapper.selectByPrimaryKey(id);
    }
}
