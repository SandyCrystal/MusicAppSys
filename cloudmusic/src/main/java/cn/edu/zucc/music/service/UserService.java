package cn.edu.zucc.music.service;

import cn.edu.zucc.music.model.User;

import java.util.List;

public interface UserService {

    int addUser(User user); // 注册
    int deleteUser(User user);
    int updateUser(User user);

    User findById(String userId);
    User findByName(String userName);
    String findMaxId();
    List<User> findAll();
}
