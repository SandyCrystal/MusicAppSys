package cn.edu.zucc.music.service.impl;

import cn.edu.zucc.music.dao.LikeMapper;
import cn.edu.zucc.music.model.Like;
import cn.edu.zucc.music.service.LikeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service(value = "LikeService")
public class LikeServiceImpl implements LikeService {
    @Resource
    LikeMapper likeMapper;

    @Override
    public List<Like> findMusicCommentByUserId(String user_id,int type) {
        return likeMapper.findMusicCommentByUserId(user_id,type);
    }


    @Override
    public int addLike(String userId, String targetId, int type) {
        Like like =new Like();
        like.setLikeUserId(userId);
        like.setTolikedId(targetId);
        like.setLikeType(type);
        return likeMapper.insert(like);
    }

    @Override
    public int disLiked(String userId, String targetId, int type) {

        return likeMapper.deleteLike(userId,targetId,type);
    }
}
