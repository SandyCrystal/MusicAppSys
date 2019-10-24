package cn.edu.zucc.music.service.impl;

import cn.edu.zucc.music.dao.CommentMapper;
import cn.edu.zucc.music.model.Comment;
import cn.edu.zucc.music.service.CommentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    @Resource
    private CommentMapper commentMapper;
    @Override
    public int addComment(Comment comment) {
        return 0;
    }

    @Override
    public int deleteComment(Comment comment) {
        return 0;
    }

    @Override
    public int updateComment(Comment comment) {
        return 0;
    }

    @Override
    public Comment findById(int id) {
        return commentMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Comment> findAll() {
        return null;
    }
}
