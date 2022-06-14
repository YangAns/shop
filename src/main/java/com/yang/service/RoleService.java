package com.yang.service;

import com.yang.bean.Role;
import com.yang.vo.RoleVo;

import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2021/11/29 - 19:51
 */
public interface RoleService {
    /**
     * 查询角色列表
     * @param roleVo
     * @return
     */
    List<Role> findRoleList(RoleVo roleVo);

    /**
     * 添加角色
     * @param role
     * @return
     */
    int addRole(Role role);

    /**
     * 修改角色
     * @param role
     * @return
     */
    int updateRole(Role role);

    /**
     * 删除角色
     * @param id
     * @return
     */
    int deleteById(Integer id);


    /**
     * 保存角色菜单关系
     * @param ids
     * @param roleId
     * @return
     */
    int saveRoleMenu(String ids, Integer roleId);

    /**
     * 查询所有角色列表
     * @return
     */
    List<Map<String,Object>> findRoleListByMap();

    /**
     * 根据员工ID查询该员工拥有的角色列表
     * @param adminId
     * @return
     */
    List<Integer> findAdminRoleByAdminId(Integer adminId);


    ///**
    // * 删除原有关系
    // * @param roleId
    // */
    //void deleteRoleMenu(Integer roleId);
    ///**
    // * 添加角色菜单关系数据
    // * @param roleId
    // * @param menuId
    // */
    //void addRoleMenu(@Param("roleId") Integer roleId,@Param("menuId") String menuId);

}
