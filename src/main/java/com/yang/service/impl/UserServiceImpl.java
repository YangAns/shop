package com.yang.service.impl;

import com.yang.bean.User;
import com.yang.mapper.UserMapper;
import com.yang.service.UserService;
import com.yang.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(String userName, String password) {
        return userMapper.login(userName,password);
    }

    @Override
    public int addUser(User user) {
        return userMapper.addUser(user);
    }

    @Override
    public User findUserByName(String userName) {
        return userMapper.findUserByName(userName);
    }

    @Override
    public User findUserByEmail(String email) {
        return userMapper.findUserByEmail(email);
    }

    @Override
    public List<User> findUserList(UserVo userVo) {
        return userMapper.findUserList(userVo);
    }

    @Override
    public User findUserById(int id) {
        return userMapper.findUserById(id);
    }

    @Override
    public int updateUser(User user) {
        return userMapper.updateUser(user);
    }

    @Override
    public int changeUserStatus(int id, int status) {
        return userMapper.changeUserStatus(id,status);
    }

    @Override
    public int deleteUserById(int id) {
        return userMapper.deleteUserById(id);
    }

    @Override
    public int findTotalUser() {
        return userMapper.findTotalUser();
    }

    @Override
    public int updatePasswordByEmail(String password, String email) {
        return userMapper.updatePasswordByEmail(password,email);
    }

    @Override
    public User findUserPicById(int id) {
        return userMapper.findUserPicById(id);
    }
}
