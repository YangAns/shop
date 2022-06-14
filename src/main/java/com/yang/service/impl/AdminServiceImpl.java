package com.yang.service.impl;

import com.yang.bean.Admin;
import com.yang.mapper.AdminMapper;
import com.yang.service.AdminService;
import com.yang.vo.AdminVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminMapper adminMapper;
    @Override
    public Admin login(String loginName, String password) {
        return adminMapper.login(loginName,password);
    }

    @Override
    public List<Admin> findAdminList(AdminVo adminVo) {
        return adminMapper.findAdminList(adminVo);
    }

    @Override
    public int addAdmin(Admin admin) {
        admin.setCreateDate(new Date());
        return adminMapper.addAdmin(admin);
    }

    @Override
    public int updateAdmin(Admin admin) {
        admin.setCreateDate(new Date());
        return adminMapper.updateAdmin(admin);
    }

    @Override
    public int updateAdminPwd(String newPwd,int id) {
        return adminMapper.updateAdminPwd(newPwd,id);
    }

    @Override
    public int getAdminCountByRoleId(int roleId) {
        return adminMapper.getAdminCountByRoleId(roleId);
    }

    @Override
    public boolean saveAdminRole(String roleIds, Integer adminId) {
        try {
            //先删除管理员角色关系表的数据
            adminMapper.deleteAdminAndRole(adminId);
            //再保存管理员角色关系
            String [] idStr = roleIds.split(",");
            for (String s : idStr) {
                adminMapper.addAdminRole(s, adminId);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public int deleteById(Integer id) {
        //同时删除管理员与角色的关系
        adminMapper.deleteAdminAndRole(id);
        //调用删除管理员的方法
        return adminMapper.deleteById(id);
    }

    @Override
    public Admin findAdminByLoginName(String loginName) {
        return adminMapper.findAdminByLoginName(loginName);
    }

    @Override
    public Admin findAdminById(int id) {
        return adminMapper.findAdminById(id);
    }

    @Override
    public int findTotalAdmin() {
        return adminMapper.findTotalAdmin();
    }
}
