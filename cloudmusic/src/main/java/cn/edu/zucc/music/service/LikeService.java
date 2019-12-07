package cn.edu.zucc.music.service;

import cn.edu.zucc.music.model.Like;

import java.util.List;

public interface LikeService {
    List<Like> findMusicCommentByUserId(String user_id,int type);
    int addLike(String userId, String targetId, int type);
    int disLiked(String userId, String targetId,int type);
}
