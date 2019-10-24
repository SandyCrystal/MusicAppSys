package cn.edu.zucc.music.service;

import cn.edu.zucc.music.model.Follow;

import java.util.List;

public interface FollowService {
    int addFollow(Follow comment);
    int deleteFollow(Follow comment);
    int updateFollow(Follow comment);
    Follow findById(int id);
    List<Follow> findAll();
}
