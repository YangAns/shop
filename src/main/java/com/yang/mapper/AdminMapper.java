package com.yang.mapper;

import com.yang.bean.Admin;
import com.yang.vo.AdminVo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminMapper {
    /**
     * 管理员登录
     * @param loginName
     * @param password
     * @return
     */
    Admin login(@Param("loginName") String loginName, @Param("password") String password);

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
    int updateAdminPwd(@Param("newPwd") String newPwd, @Param("id") int id);


    //删除管理员同时删除管理员和角色的关系
    /**
     * 删除管理员
     * @param id
     * @return
     */
    int deleteById(Integer id);

    /**
     * 删除管理员角色关系数据
     * @param id
     */
    void deleteAdminAndRole(Integer id);
  //------------------------------------------




    /**
     * 保存管理员角色关系数据
     * @param roleId
     * @param adminId
     */
    @Insert("insert into admin_role (aid,rid) values(#{aid},#{rid})")
    void addAdminRole(@Param("rid") String roleId, @Param("aid") Integer adminId);


    /**
     * 根据角色编号查询管理员数量
     * @param roleId
     * @return
     */
    int getAdminCountByRoleId(int roleId);


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
