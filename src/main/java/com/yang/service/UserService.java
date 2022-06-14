package com.yang.service;

import com.yang.bean.User;
import com.yang.vo.UserVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author yang
 * @date 2021/11/8 - 11:17
 */
public interface UserService {
    /**
     * 前台用户登录
     * @param userName
     * @param password
     * @return
     */
    User login(@Param("userName") String userName, @Param("password") String password);


    /**
     * 前台用户添加
     * @param user
     * @return
     */
    int addUser(User user);


    /**
     * 验证用户名是否已存在
     * @param userName
     * @return
     */
    User findUserByName(String userName);

    /**
     * 验证邮箱是否已存在
     * @param email
     * @return
     */
    User findUserByEmail(String email);

    /**
     * 查询所有用户列表
     * @param userVo
     * @return
     */
    List<User> findUserList(UserVo userVo);

    /**
     * 前台
     * 根据id 查询一条用户
     * @param id session传过来的id值
     * @return
     */

    User findUserById(int id);

    /**
     * 前台用户修改
     * @param user
     * @return
     */
    int updateUser(User user);

    /**
     * 禁用|解禁用户
     * @param id
     * @param status
     * @return
     */
    int changeUserStatus(int id, int status);

    /**
     * 删除用户
     * @param id
     * @return
     */
    int deleteUserById(int id);

    /**
     * 查询总用户数量
     * @return
     */
    int findTotalUser();

    /**
     * 前台用户找回密码
     * @param password
     * @param email
     * @return
     */
    int updatePasswordByEmail(String password, String email);

    User findUserPicById(int id);

}
