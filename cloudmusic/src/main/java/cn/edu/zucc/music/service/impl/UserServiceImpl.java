package cn.edu.zucc.music.service.impl;


import cn.edu.zucc.music.dao.UserMapper;
import cn.edu.zucc.music.model.User;
import cn.edu.zucc.music.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    UserMapper userMapper;

    @Override
    public int addUser(User user) {
        userMapper.insert(user);
        return 1;
    }

    @Override
    public int deleteUser(User user) {
        return 0;
    }

    @Override
    public int updateUser(User user) {
        userMapper.updateByUserName(user);
        return 1;
    }

    @Override
    public User findById(String userId) {
        return userMapper.selectByPrimaryKey(userId);
    }

    @Override
    public User findByName(String userName) { return userMapper.selectByUserName(userName);}

    @Override
    public String findMaxId() {
        return userMapper.findMaxId();
    }

    @Override
    public List<User> findAll() {
        return null;
    }
}
