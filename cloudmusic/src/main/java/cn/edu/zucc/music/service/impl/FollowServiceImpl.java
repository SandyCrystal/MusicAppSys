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
    public int addFollow(Follow comment) {
        return 0;
    }

    @Override
    public int deleteFollow(Follow comment) {
        return 0;
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
    public List<Follow> getFollowedUsers(String user_id) {
        return followMapper.getFollowedUsers(user_id);
    }
}
