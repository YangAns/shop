package com.yang.mapper;

import com.yang.bean.Menu;

import java.util.List;

/**
 * @author yang
 * @date 2021/10/29 - 15:13
 */
public interface MenuMapper {

    /**
     * 查询所有菜单列表
     * @return
     */
    List<Menu> findMenuList();

    /**
     * 根据角色ID查询该角色拥有的菜单ID集合
     * @param roleId
     * @return
     */
    List<Integer> findMenuIdListByRoleId(int roleId);

    /**
     * 根据菜单编号查询菜单信息
     * @param currentRoleMenuIds
     * @return
     */
    List<Menu> findMenuByMenuId(List<Integer> currentRoleMenuIds);

    /**
     * 根据当前登录管理员的角色查询菜单列表
     * @param adminId
     * @return
     */
    List<Menu> findMenuListByAdminId(Integer adminId);

}
