package com.yang.controller.front;

import com.yang.bean.Collect;
import com.yang.bean.Goods;
import com.yang.bean.User;
import com.yang.service.CollectService;
import com.yang.service.GoodsService;
import com.yang.utils.SystemConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/collect")
public class CollectController {

    @Autowired
    private CollectService collectService;

    @Autowired
    private GoodsService goodsService;


    @RequestMapping("/myCollect")
    public String myCollect(Model model, HttpSession session) {
        //判断用户是否已经登录
        User u = (User) session.getAttribute("user");
        if (u != null) {
            List<Collect> collectList = collectService.findCollectListByUid(u.getId());
            model.addAttribute("collectList", collectList);
            return "front/front_collect/showCollect";
        } else {
            return "redirect:/user/toLogin";
        }
    }

    /**
     * 添加收藏
     *
     * @param collect
     * @param session
     * @return
     */
    @RequestMapping("/addCollect")
    @ResponseBody
    public Map<Object, Object> addCart(Collect collect, HttpSession session) {
        Map<Object, Object> map = new HashMap<>();
        User u = (User) session.getAttribute("user");
        if (u != null) {
            collect.setUid(u.getId());
            //从数据库中查找该商品判断是否已经被收藏了
            if(collectService.findCollectByUidGid(u.getId(),collect.getGid())!=null){
                map.put(SystemConstant.SUCCESS, "collected");//已经收藏了
                map.put(SystemConstant.MESSAGE, "你已经收藏过该商品了，不能重复收藏");
            }else{
                if (collectService.addCollect(collect) > 0) {
                    map.put(SystemConstant.SUCCESS, "true");//成功
                    map.put(SystemConstant.MESSAGE, "收藏成功");
                    //商品收藏数加1
                    Goods goods = goodsService.findGoodsById(collect.getGid());
                    //Goods goods = new Goods();
                    //goods.setId(collect.getGid());
                    //goods.setCollectNum(goods.getCollectNum()+1);
                    System.out.println(goods);
                    goods.setCollectNum(goods.getCollectNum() + 1);
                    goodsService.updateGoods(goods);
                } else {
                    map.put(SystemConstant.SUCCESS, "false");//成功
                    map.put(SystemConstant.MESSAGE, "收藏失败");
                }
            }
        } else {
            map.put(SystemConstant.SUCCESS, "sessionError");
            map.put(SystemConstant.MESSAGE, "请先登录");
        }
        return map;
    }

    @RequestMapping("/deleteById")
    public String deleteById(int id, HttpSession session) {
        User u = (User) session.getAttribute("user");
        if(u!=null){
            collectService.deleteById(id);
            return "redirect:/collect/myCollect";
        }else {
            return "redirect:/user/toLogin";
        }
    }
}
