package com.yang.controller.front;

import com.yang.bean.Cart;
import com.yang.bean.Goods;
import com.yang.bean.User;
import com.yang.service.CartService;
import com.yang.service.GoodsService;
import com.yang.utils.SystemConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("cart")
public class CartController {
    @Autowired
    private CartService cartService;
    @Autowired
    private GoodsService goodsService;
    /**
     * 跳转到购物车页面
     * @return
     */
    @RequestMapping("/showMyCart")
    public String showMyCart(HttpSession session, Model model){
        //取到session里的值
        User u = (User) session.getAttribute("user");
        if(u!=null){
            List<Cart> cartList = cartService.findCartListByUserId(u.getId());
            model.addAttribute("cartList",cartList);
            return "front/front_cart/showCart";
        }else {
            return "redirect:/user/toLogin";
        }
    }


    /**
     * 添加购物车
     * @param cart
     * @param session
     * @return
     */
    @RequestMapping("/addCart")
    @ResponseBody
    public Map<Object, Object> addCart(Cart cart, HttpSession session){
        Map<Object, Object> map = new HashMap<>();
        User u = (User) session.getAttribute("user");
        if(u!=null){
            cart.setUid(u.getId());
            Goods goods = goodsService.findGoodsById(cart.getGid());
            double price = goods.getPrice();
            cart.setPrice(price);
            if(goods.getDiscount()!=null){
                price = price*goods.getDiscount()/10;
                BigDecimal bg = new BigDecimal(price).setScale(2, RoundingMode.UP);
                cart.setPrice(bg.doubleValue());
                price = bg.doubleValue();
            }
            double total = price*cart.getNum();
            BigDecimal bg = new BigDecimal(total).setScale(2, RoundingMode.UP);
            cart.setTotalPrice(bg.doubleValue());
            if(cartService.addCart(cart)>0){
                map.put(SystemConstant.SUCCESS,"true");//成功
                map.put(SystemConstant.MESSAGE,"成功加入购物车");
            }else {
                map.put(SystemConstant.SUCCESS,"false");//成功
                map.put(SystemConstant.MESSAGE,"加入购物车失败");
            }
        }else {
            map.put(SystemConstant.SUCCESS,"sessionError");
            map.put(SystemConstant.MESSAGE,"请先登录");
        }
        return map;
    }

    /**
     * 删除购物车
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    @ResponseBody
    public Map<String,Object> deleteById(int id){
        Map<String, Object> map = new HashMap<String,Object>();
        if(cartService.deleteById(id)>0){
            map.put(SystemConstant.SUCCESS,true);//成功
            map.put(SystemConstant.MESSAGE,"删除成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"删除失败");
        }
        return map;
    }
}
