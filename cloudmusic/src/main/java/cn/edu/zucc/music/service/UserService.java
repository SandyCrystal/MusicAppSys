package cn.edu.zucc.music.service;


import cn.edu.zucc.music.model.User;

import java.util.List;

public interface UserService {
    int addUser(User user);
    int deleteUser(User user);
    int updateUser(User user);
    User findById(String userId);
    List<User> findAll();
}
