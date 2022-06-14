package com.yang.service.impl;

import com.yang.bean.Menu;
import com.yang.mapper.MenuMapper;
import com.yang.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author yang
 * @date 2021/10/29 - 15:17
 */
@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuMapper menuMapper;
    @Override
    public List<Menu> findMenuList() {
        return menuMapper.findMenuList();
    }

    @Override
    public List<Integer> findMenuIdListByRoleId(int roleId) {
        return menuMapper.findMenuIdListByRoleId(roleId);
    }

    @Override
    public List<Menu> findMenuByMenuId(List<Integer> currentRoleMenuIds) {
        return menuMapper.findMenuByMenuId(currentRoleMenuIds);
    }

    @Override
    public List<Menu> findMenuListByAdminId(Integer adminId) {
        return menuMapper.findMenuListByAdminId(adminId);
    }
}
