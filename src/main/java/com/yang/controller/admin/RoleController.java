package com.yang.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yang.bean.Menu;
import com.yang.bean.Role;
import com.yang.service.AdminService;
import com.yang.service.MenuService;
import com.yang.service.RoleService;
import com.yang.utils.DataGridViewResult;
import com.yang.utils.SystemConstant;
import com.yang.utils.TreeNode;
import com.yang.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/role")
public class RoleController {
    @Autowired
    private RoleService roleService;
    @Autowired
    private MenuService menuService;
    @Autowired
    private AdminService adminService;

    /**
     * 查询角色列表
     *
     * @param roleVo
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public DataGridViewResult list(RoleVo roleVo) {
        //设置分页信息
        PageHelper.startPage(roleVo.getPage(), roleVo.getLimit());
        //调用查询角色列表的方法
        List<Role> roleList = roleService.findRoleList(roleVo);
        //创建分页信息对象
        PageInfo<Role> pageInfo = new PageInfo<Role>(roleList);
        //返回数据(参数1：总数量，参数2：角色列表)
        return new DataGridViewResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 添加角色
     * @param role
     * @return
     */
    @RequestMapping("/addRole")
    @ResponseBody
    public Map<String, Object> addRole(Role role) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (roleService.addRole(role) > 0) {
            map.put(SystemConstant.SUCCESS, true);//成功
            map.put(SystemConstant.MESSAGE, "添加成功");
        } else {
            map.put(SystemConstant.SUCCESS, false);//失败
            map.put(SystemConstant.MESSAGE, "添加失败");
        }
        return map;
    }

    /**
     * 修改角色
     *
     * @param role
     * @return
     */
    @RequestMapping("/updateRole")
    @ResponseBody
    public Map<Object, Object> updateRole(Role role) {
        System.out.println("----->c"+role);
        Map<Object, Object> map = new HashMap<>();
        if (roleService.updateRole(role) > 0) {
            map.put(SystemConstant.SUCCESS, true);//成功
            map.put(SystemConstant.MESSAGE, "修改成功");
        } else {
            map.put(SystemConstant.SUCCESS, false);//失败
            map.put(SystemConstant.MESSAGE, "修改失败");
        }
        return map;
    }


    /**
     * 检查该角色下是否存在管理员信息
     */
    @RequestMapping("/checkRoleHaveAdmin")
    @ResponseBody
    public Map<Object, Object> checkRoleHaveAdmin(int id) {
        Map<Object, Object> map = new HashMap<>();
        if (adminService.getAdminCountByRoleId(id) > 0) {
            map.put(SystemConstant.EXIST, true);//存在
            map.put(SystemConstant.MESSAGE, "该角色存在管理员信息，无法删除");
        } else {
            map.put(SystemConstant.SUCCESS, false);//不存在
        }
        return map;
    }


    /**
     * 删除角色
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    @ResponseBody
    public Map<Object, Object> deleteById(int id) {
        Map<Object, Object> map = new HashMap<>();
        if (roleService.deleteById(id) > 0) {
            map.put(SystemConstant.SUCCESS, true);//成功
            map.put(SystemConstant.MESSAGE, "删除成功");
        } else {
            map.put(SystemConstant.SUCCESS, false);//失败
            map.put(SystemConstant.MESSAGE, "删除失败");
        }
        return map;
    }

    /**
     * 根据角色ID查询该角色拥有的菜单
     * @param roleId        角色ID
     * @return
     */
    @RequestMapping("/initMenuTree")
    @ResponseBody
    public DataGridViewResult initMenuTree(Integer roleId){
        //调用查询菜单列表的方法
        List<Menu> menuList = menuService.findMenuList();
        //调用根据角色ID查询该角色已经拥有的菜单ID的方法
        List<Integer> currentRoleMenuIds = menuService.findMenuIdListByRoleId(roleId);
        //定义集合，保存菜单信息
        List<Menu> currentMenus = new ArrayList<Menu>();
        //判断集合是否存在数据
        if(currentRoleMenuIds!=null && currentRoleMenuIds.size()>0){
            //根据菜单ID查询该菜单的信息
            currentMenus = menuService.findMenuByMenuId(currentRoleMenuIds);
        }
        //创建集合保存树节点信息
        List<TreeNode> treeNodes = new ArrayList<TreeNode>();
        //循环遍历所有菜单
        for (Menu menu : menuList) {
            //定义变量，标识是否选中
            String checkArr = "0";//0表示复选框不选中，1表示选中复选框
            //内层循环遍历当前角色拥有的权限菜单
            //循环比较的原因：比较两个集合中的数据是否有相同的，有相同的表示当前角色拥有这个权限
            for (Menu currentMenu : currentMenus) {
                //如果ID相等，表示当前角色有这个菜单，有这个菜单则需要将复选框选中
                if(menu.getId() == currentMenu.getId()){
                    checkArr ="1";//选中
                    break;
                }
            }
            //定义变量，表示菜单是否展开
            Boolean spread = (menu.getSpread()==null || menu.getSpread()==1) ? true : false;
            treeNodes.add(new TreeNode(menu.getId(),menu.getPid(),menu.getTitle(),spread,checkArr));
        }
        //将数据返回到页面
        return new DataGridViewResult(treeNodes);
    }


    /**
     * 分配菜单
     * @param ids
     * @param roleId
     * @return
     */
    @RequestMapping("/saveRoleMenu")
    @ResponseBody
    public Map<String,Object> saveRoleMenu(String ids,Integer roleId){
        Map<String,Object> map = new HashMap<String,Object>();
        //调用保存角色菜单关系的方法
        if(roleService.saveRoleMenu(ids,roleId)>0){
            map.put("message","菜单分配成功");
        }else{
            map.put("message","菜单分配失败");
        }
        return map;
    }


    /**
     * 根据管理员ID查询该管理员拥有的角色列表
     * @param id
     * @return
     */
    @RequestMapping("/initRoleListByAdminId")
    @ResponseBody
    public DataGridViewResult initRoleListByAdminId(int id){
        //调用查询所有角色列表的方法
        List<Map<String, Object>> roleList = roleService.findRoleListByMap();
        //调用根据员工ID查询该员工拥有的角色列表的方法
        List<Integer> roleIds = roleService.findAdminRoleByAdminId(id);
        //循环比较两个集合中的角色ID值是否相等，相等则选中该角色
        for (Map<String, Object> map : roleList) {
            //定义变量，标识是否选中
            boolean flag = false;//不选中
            //获取每一个角色ID
            Integer rid = (Integer) map.get("id");//id是主键，以主键作为map集合中key
            //内层循环遍历该员工拥有的角色列表
            for (Integer roleId : roleIds) {
                //判断两个集合中是否存在角色ID相同
                if(rid ==  roleId){
                    flag = true;//选中该角色
                    break;
                }
            }
            //将状态保存在map集合中
            map.put("LAY_CHECKED",flag);//key必须是LAY_CHECKED
        }
        return new DataGridViewResult(Long.valueOf(roleList.size()),roleList);
    }



}
