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
    public List<Like> findMusicCommentByUserId(String user_id) {
        return likeMapper.findMusicCommentByUserId(user_id);
    }
}
