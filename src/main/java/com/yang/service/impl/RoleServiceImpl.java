package com.yang.service.impl;

import com.yang.bean.Role;
import com.yang.mapper.RoleMapper;
import com.yang.service.RoleService;
import com.yang.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;
    @Override
    public List<Role> findRoleList(RoleVo roleVo) {
        return roleMapper.findRoleList(roleVo);
    }
    @Override
    public int addRole(Role role) {
        return roleMapper.addRole(role);
    }
    @Override
    public int updateRole(Role role) {
        System.out.println("----->s"+role);
        return roleMapper.updateRole(role);
    }
    @Override
    public int deleteById(Integer id) {
        return roleMapper.deleteById(id);
    }

    @Override
    public int saveRoleMenu(String ids, Integer roleId) {
        try {
            //删除原有的菜单关系
            roleMapper.deleteRoleMenu(roleId);//根据角色ID删除
            //将ids拆分成数组
            String [] idsStr = ids.split(",");
            //循环调用
            for (String s : idsStr) {
                //调用保存菜单角色关系的方法
                roleMapper.addRoleMenu(roleId, s);
            }
            return 1;//成功
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;//失败
    }

    @Override
    public List<Map<String, Object>> findRoleListByMap() {
        return roleMapper.findRoleListByMap();
    }

    @Override
    public List<Integer> findAdminRoleByAdminId(Integer adminId) {
        return roleMapper.findAdminRoleByAdminId(adminId);
    }


    //@Override
    //public void deleteRoleMenu(Integer roleId) {
    //
    //}
    //
    //@Override
    //public void addRoleMenu(Integer roleId, String menuId) {
    //
    //}
}
