package com.yang.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 负责跳转页面(后台管理页面)
 */
@Controller
@RequestMapping("/admin")
public class SystemController {
    /**
     * 去到登录页面
     * @return
     */
    @RequestMapping("/login.html")
    public String login(){
        return "admin/login";
    }

    /**
     * 去到后台首页
     * @return
     */
    @RequestMapping("/main.html")
    public String main(){
        return "admin/main";
    }

    /**
     * 去到管理员管理
     * @return
     */
    @RequestMapping("/toAdminManager")
    public String toAdminManager(){
        return "admin/adminuser/listAdmin";
    }

    /**
     * 去到一级分类表
     * @return
     */
    @RequestMapping("/toGoodsTypeOneManager")
    public String toGoodsTypeOneManager(){
        return "admin/goodsType/listGoodsTypeOne";
    }

    /**
     * 去到二级分类表
     * @return
     */
    @RequestMapping("/toGoodsTypeTwoManager")
    public String toGoodsTypeTwoManager(Integer pid, Model model){
        model.addAttribute("pid",pid);
        return "admin/goodsType/listGoodsTypeTwo";
    }
    /**
     * 去到商品管理页面
     * @return
     */
    @RequestMapping("/toGoodsManager")
    public String toGoodsManager(){
        return "admin/goods/listGoods";
    }


    /**
     * 去到前台用户管理页面
     * @return
     */
    @RequestMapping("/toUserManager")
    public String toUserManager(){
        return "admin/user/listUser";
    }


    /**
     * 去到公告管理页面
     * @return
     */
    @RequestMapping("/toNoticeManager")
    public String toNoticeManager(){
        return "admin/notice/listNotice";
    }


    /**
     * 去到订单管理页面
     * @return
     */
    @RequestMapping("/toOrderManager")
    public String toOrderManager(){
        return "admin/order/listOrder";
    }

    /**
     * 去到订单详情页面
     * @return
     */
    @RequestMapping("/toOrderDetail")
    public String toOrderDetail(Integer orderId, Model model){
        model.addAttribute("orderId",orderId);
        return "admin/order/listOrderDetail";
    }


    /**
     * 去到反馈管理页面
     * @return
     */
    @RequestMapping("/toFeedbackManager")
    public String toFeedbackManager(){
        return "admin/feedback/listFeedback";
    }

    /**
     * 去到反馈管理页面
     * @return
     */
    @RequestMapping("/toEvaluateManager")
    public String toEvaluateManager(){
        return "admin/evaluate/listEvaluate";
    }


    /**
     * 去到管理员修改密码页面
     * @return
     */
    @RequestMapping("/updatePass")
    public String updatePass(){
        return "admin/updatepass";
    }

    /**
     * 去到管理员信息页面
     * @return
     */
    @RequestMapping("/adminInfo")
    public String adminInfo(){
        return "admin/adminInfo";
    }

    /**
     * 去到角色管理页面
     * @return
     */
    @RequestMapping("/toRoleManager")
    public String toRoleManager(){
        return "admin/role/listRole";
    }
}
