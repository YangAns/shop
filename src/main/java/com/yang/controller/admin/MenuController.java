package com.yang.controller.admin;

import com.yang.bean.Admin;
import com.yang.bean.Menu;
import com.yang.bean.Notice;
import com.yang.service.*;
import com.yang.utils.MenuNode;
import com.yang.utils.SystemConstant;
import com.yang.utils.TreeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author yang
 * @date 2021/10/29 - 15:23
 */
@Controller
@RequestMapping("admin/menu")
public class MenuController {
    @Autowired
    private MenuService menuService;

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private UserService userService;

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private AdminService adminService;

    @Autowired
    private EvaluateService evaluateService;



    /**
     * 加载菜单列表
     * @return
     */
    @RequestMapping("/loadMenuList")
    @ResponseBody
    public Map<String,Object> loadMenuList(HttpSession session){
        //创建Map集合，保存MenuInfo菜单信息
        Map<String,Object> map = new HashMap<String,Object>();
        //创建Map集合，保存homeInfo信息
        Map<String,Object> homeInfo = new HashMap<String,Object>();
        //创建Map集合，保存logoInfo信息
        Map<String,Object> logoInfo = new HashMap<String,Object>();
        //调用查询所有菜单列表的方法
        //List<Menu> menuList = menuService.findMenuList();
        //获取当前登录员工
        Admin admin = (Admin) session.getAttribute(SystemConstant.LOGINUSER);
        //根据当前用户的角色动态显示菜单列表
        List<Menu> menuList = menuService.findMenuListByAdminId(admin.getId());
        //创建集合，保存菜单关系
        List<MenuNode> menuNodeList = new ArrayList<MenuNode>();
        //循环遍历菜单列表,目的是创建菜单之间层级关系
        for (Menu m : menuList) {
            //创建菜单节点对象
            MenuNode menuNode = new MenuNode();
            menuNode.setHref(m.getHref());//链接地址
            menuNode.setIcon(m.getIcon());//菜单图标
            menuNode.setId(m.getId());//菜单编号
            menuNode.setPid(m.getPid());//父级菜单编号
            menuNode.setSpread(m.getSpread());//是否展开
            menuNode.setTarget(m.getTarget());//打开方式
            menuNode.setTitle(m.getTitle());//菜单名称
            //将对象添加到集合
            menuNodeList.add(menuNode);
        }
        //保存HomeInfo信息
        homeInfo.put("title","首页");
        homeInfo.put("href","/shop/admin/menu/welcome.html");
        //保存logoInfo信息
        logoInfo.put("title","数码商城后台");//logo标题
        logoInfo.put("image","/shop/statics/layuimini/images/logo.png");//logo图
        logoInfo.put("href","/shop/admin/main.html");//首页地址
        //将菜单信息添加到MenuInfo集合中
        map.put("homeInfo",homeInfo);
        map.put("logoInfo",logoInfo);
        map.put("menuInfo", TreeUtil.toTree(menuNodeList,0));
        return map;
    }


    /**
     * 首页数据显示
     * @return
     */
    @RequestMapping("/welcome.html")
    public String toWelcome(Model model){
        List<Notice> noticeList = noticeService.findNoticeList(null);
        model.addAttribute("noticeList",noticeList);
        return "admin/welcome2";
    }

    /**
     * 首页数据统计
     * @return
     */
    @RequestMapping("/dataStatistics")
    @ResponseBody
    public Map<String,Object> dataStatistics(){
        Map<String, Object> map = new HashMap<>();
        int totalGoods = goodsService.findTotalGoods();
        int totalUser = userService.findTotalUser();
        int totalAdmin = adminService.findTotalAdmin();
        int totalEvaluate = evaluateService.findTotalEvaluate();
        map.put("totalGoods",totalGoods);
        map.put("totalUser",totalUser);
        map.put("totalAdmin",totalAdmin);
        map.put("totalEvaluate",totalEvaluate);
        return map;
    }

}
