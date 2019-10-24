package cn.edu.zucc.music.service;

import cn.edu.zucc.music.model.Comment;

import java.util.List;

public interface CommentService {
    int addComment(Comment comment);
    int deleteComment(Comment comment);
    int updateComment(Comment comment);
    Comment findById(int id);
    List<Comment> findAll();
}
