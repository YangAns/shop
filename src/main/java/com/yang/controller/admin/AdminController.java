package com.yang.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yang.bean.Admin;
import com.yang.service.AdminService;
import com.yang.utils.DataGridViewResult;
import com.yang.utils.SystemConstant;
import com.yang.vo.AdminVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/adminuser")
public class AdminController {
    @Autowired
    private AdminService adminService;

    /**
     * 管理员登录
     * @param loginName 用户名
     * @param password 密码
     * @param session session
     * @return map
     */
    @RequestMapping("/login")
    @ResponseBody
    public Map<String,Object> login(String loginName, String password, HttpSession session){
        Map<String, Object> map = new HashMap<>();
        Admin admin = adminService.login(loginName, password);
        if(admin!=null){
            session.setAttribute(SystemConstant.LOGINUSER,admin);
            map.put(SystemConstant.SUCCESS,true);
        }else{
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"账号或密码错误，登录失败");
        }
        return map;
    }

    /**
     * 退出登录
     * @return
     */
    @RequestMapping("/loginout")
    public String loginout(HttpSession session){
        //清空session
        session.removeAttribute(SystemConstant.LOGINUSER);
        //重定向到登录页面
        return "redirect:admin/login.html";
    }



    /**
     * 查询管理员列表
     *
     * @param adminVo
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public DataGridViewResult list(AdminVo adminVo) {
        //设置分页信息
        PageHelper.startPage(adminVo.getPage(), adminVo.getLimit());
        //调用查询管理员列表的方法
        List<Admin> adminList = adminService.findAdminList(adminVo);
        //创建分页信息对象
        PageInfo<Admin> pageInfo = new PageInfo<Admin>(adminList);
        //返回数据(参数1：总数量，参数2：角色列表)
        return new DataGridViewResult(pageInfo.getTotal(), pageInfo.getList());
    }


    /**
     * 添加管理员
     *
     * @param admin
     * @return
     */
    @RequestMapping("/addAdmin")
    @ResponseBody
    public Map<String, Object> addAdmin(Admin admin) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (adminService.addAdmin(admin) > 0) {
            map.put(SystemConstant.SUCCESS, true);//成功
            map.put(SystemConstant.MESSAGE, "添加成功");
        } else {
            map.put(SystemConstant.SUCCESS, false);//失败
            map.put(SystemConstant.MESSAGE, "添加失败");
        }
        return map;
    }

    /**
     *验证登录名是否重复
     * @param loginName
     * @return
     */
    @RequestMapping("/findAdminByLoginName")
    @ResponseBody
    public Map<String, Object> findAdminByLoginName(String loginName) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (adminService.findAdminByLoginName(loginName)!=null) {
            map.put(SystemConstant.SUCCESS, true);//成功
            map.put(SystemConstant.MESSAGE, "登录名称已经被使用");
        } else {
            map.put(SystemConstant.SUCCESS, false);//失败
        }
        return map;
    }

    /**
     * 修改管理员信息
     * @param admin
     * @return
     */
    @RequestMapping("/updateAdmin")
    @ResponseBody
    public Map<Object, Object> updateAdmin(Admin admin) {
        Map<Object, Object> map = new HashMap<>();
        if (adminService.updateAdmin(admin) > 0) {
            map.put(SystemConstant.SUCCESS, true);//成功
            map.put(SystemConstant.MESSAGE, "修改成功");
        } else {
            map.put(SystemConstant.SUCCESS, false);//失败
            map.put(SystemConstant.MESSAGE, "修改失败");
        }
        return map;
    }

    /**
     * 管理员修改密码
     * @param newPwd
     * @return
     */
    @RequestMapping("/updateAdminPwd")
    @ResponseBody
    public Map<Object, Object> updateAdminPwd(String newPwd, HttpSession session) {
        Map<Object, Object> map = new HashMap<>();
        Admin admin = (Admin) session.getAttribute(SystemConstant.LOGINUSER);
        if (adminService.updateAdminPwd(newPwd,admin.getId()) > 0) {
            map.put(SystemConstant.SUCCESS, true);//成功
            map.put(SystemConstant.MESSAGE, "密码修改成功！请重新登录");
        } else {
            map.put(SystemConstant.SUCCESS, false);//失败
            map.put(SystemConstant.MESSAGE, "密码修改失败");
        }
        return map;
    }


    /**
     * 删除管理员
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    @ResponseBody
    public Map<String,Object> deleteById(int id){
        Map<String, Object> map = new HashMap<String,Object>();
        if(adminService.deleteById(id)>0){
            map.put(SystemConstant.SUCCESS,true);//成功
            map.put(SystemConstant.MESSAGE,"删除成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"删除失败");
        }
        return map;
    }

    /**
     * 分配角色
     * @param roleIds
     * @param adminId
     * @return
     */
    @RequestMapping("/saveAdminRole")
    @ResponseBody
    public Map<String,Object> saveEmployeeRole(String roleIds,Integer adminId){
        Map<String,Object> map = new HashMap<String,Object>();
        //调用保存员工角色关系的方法
        if(adminService.saveAdminRole(roleIds,adminId)){
            map.put(SystemConstant.MESSAGE,"角色分配成功");
        }else{
            map.put(SystemConstant.MESSAGE,"角色分配失败");
        }
        return map;
    }


    /**
     * 根据管理员id查询管理员信息
     * @return
     */
    @RequestMapping("/findAdminById")
    @ResponseBody
    public Admin findAdminById(HttpSession session){
        Admin admin = (Admin) session.getAttribute(SystemConstant.LOGINUSER);
        return adminService.findAdminById(admin.getId());
    }
}
