package com.yang.service;

import com.yang.bean.Admin;
import com.yang.vo.AdminVo;

import java.util.List;

/**
 * @author yang
 * @date 2021/10/28 - 21:48
 */
public interface AdminService {
    /**
     * 管理员登录
     * @param loginName
     * @param password
     * @return
     */
    Admin login(String loginName, String password);

    /**
     * 查询管理员列表
     * @param adminVo
     * @return
     */
    List<Admin> findAdminList(AdminVo adminVo);

    /**
     * 添加管理员
     * @param admin
     * @return
     */
    int addAdmin(Admin admin);


    /**
     * 修改管理员基本资料
     * @param admin
     * @return
     */
    int updateAdmin(Admin admin);

    /**
     * 修改管理员密码
     * @param newPwd
     * @return
     */
    int updateAdminPwd(String newPwd, int id);


    /**
     * 根据角色编号查询管理员数量
     * @param roleId
     * @return
     */
    int getAdminCountByRoleId(int roleId);

    /**
     * 保存管理员角色关系
     * @param roleIds
     * @param adminId
     * @return
     */
    boolean saveAdminRole(String roleIds, Integer adminId);


    /**
     * 删除管理员
     * @param id
     * @return
     */
    int deleteById(Integer id);


    /**
     * 验证登录名是否重复
     * @param loginName
     * @return
     */
    Admin findAdminByLoginName(String loginName);

    /**
     * 根据管理员id查看管理员信息
     * @param id
     * @return
     */
    Admin findAdminById(int id);

    /**
     * 查询管理员人数
     * @return
     */
    int findTotalAdmin();
}
