package com.yang.controller.front;


import com.yang.bean.Goods;
import com.yang.bean.GoodsType;
import com.yang.bean.Notice;
import com.yang.service.GoodsService;
import com.yang.service.GoodsTypeService;
import com.yang.service.NoticeService;
import com.yang.utils.GoodsTypeDto;
import com.yang.vo.GoodsTypeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * 前台首页控制层
 */
@Controller
public class IndexController {
    @Autowired
    GoodsTypeService goodsTypeService;
    @Autowired
    NoticeService noticeService;
    @Autowired
    GoodsService goodsService;
    /**
     * 前台首页展示
     * @param model
     * @return
     */
    @RequestMapping("/index.html")
    public String index(Model model) {
        //查询所有父类型
        GoodsTypeVo goodsTypeVo1 = new GoodsTypeVo();
        List<GoodsType> goodsTypeFatherList = goodsTypeService.findGoodsTypeList(goodsTypeVo1);
        List<GoodsTypeDto> list = new ArrayList<>();
        //遍历父类型
        if (goodsTypeFatherList != null && !goodsTypeFatherList.isEmpty()) {
            for (GoodsType goodsType : goodsTypeFatherList) {
                GoodsTypeDto goodsTypeDto = new GoodsTypeDto();
                //将查询出来的父类型存到实体类中
                goodsTypeDto.setFather(goodsType);
                //根据父类型查询所有子类型
                GoodsTypeVo goodsTypeVo2 = new GoodsTypeVo();
                goodsTypeVo2.setPid(goodsType.getId());
                List<GoodsType> children = goodsTypeService.findGoodsTypeList(goodsTypeVo2);
                //将该父类型下的所有子类型存到实体类中
                goodsTypeDto.setChildren(children);
                list.add(goodsTypeDto);
                model.addAttribute("type", list);
            }
        }
        //查询促销商品
        //List<Goods> saleGoodsList = goodsService.findSaleGoodsList();
        //model.addAttribute("saleGoods",saleGoodsList);
        //查询购买数量最多商品
        List<Goods> hotGoodsList = goodsService.findHotGoodsList();
        model.addAttribute("hotGoods",hotGoodsList);
        //查询最新上架商品
        List<Goods> newGoodsList = goodsService.findNewGoodsList();
        model.addAttribute("newGoods",newGoodsList);
        return "front/home";
    }

    /**
     * 去到前台公告列表页面
     * @return
     */
    @RequestMapping("/ShowNotice.html")
    public String toShowNotice(Model model){
        List<Notice> noticeList = noticeService.findNoticeList(null);
        model.addAttribute("noticeList",noticeList);
        return "front/front_notice/showNotice";
    }


    /**
     * 前台公告弹窗
     * @return
     */
    @RequestMapping("newNotice")
    @ResponseBody
    public Notice newNotice(){
        return noticeService.findNewNotice();
    }

    /**
     * 去到前台公告列表详情页面
     * @return
     */
    @RequestMapping("/noticeDetail.html")
    public String noticeDetail(int id, Model model){
        Notice notice = noticeService.findNoticeById(id);
        model.addAttribute("notice",notice);
        return "front/front_notice/noticeDetail";
    }


    /**
     * 前台按关键字或者二级分类查询
     * @return
     */
    @RequestMapping("/findFrontGoods")
    public String findFrontGoods(Goods goods, Model model){
        List<Goods> frontGoods = goodsService.findFrontGoods(goods);
        model.addAttribute("frontGoods",frontGoods);
        model.addAttribute("goods",goods);
        return "front/front_goods/showFrontGoods";
    }

    /**
     * 前台商品详情展示
     * @return
     */
    @RequestMapping("/goodsDetail/{id}")
    public String goodsDetail(@PathVariable("id") int id, Model model){
        Goods goods = goodsService.findGoodsById(id);
        model.addAttribute("goods",goods);
        return "front/front_goods/goodsDetail";
    }
}
