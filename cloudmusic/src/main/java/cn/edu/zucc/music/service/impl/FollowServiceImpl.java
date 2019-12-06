package cn.edu.zucc.music.service.impl;


import cn.edu.zucc.music.dao.FollowMapper;
import cn.edu.zucc.music.model.Dynamic;
import cn.edu.zucc.music.model.Follow;
import cn.edu.zucc.music.service.FollowService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class FollowServiceImpl implements FollowService {
    @Resource
    private FollowMapper followMapper;
    @Override
    public int addFollow(Follow follow) {
        return followMapper.insert(follow);
    }

    @Override
    public int deleteFollow(Follow follow) {
        return followMapper.deleteByPrimaryKey(follow.getFollowId());
    }

    @Override
    public int updateFollow(Follow comment) {
        return 0;
    }

    @Override
    public Follow findById(int id) {
        return followMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Follow> findAll() {
        return null;
    }

    @Override
    public List<Follow> getFollowedUsers(String userId) {
        return followMapper.getFollowedUsers(userId);
    }

    @Override
    public List<Follow> getFansUsers(String userId) {
        return followMapper.getFansUsers(userId);
    }

    @Override
    public Follow getFromMutual(String fromtoUserId, String toUserId){
        return followMapper.getFromMutual(fromtoUserId, toUserId);
    }

    @Override
    public int getMaxFollowId(){
        return followMapper.getMaxFollowId();
    }

}
