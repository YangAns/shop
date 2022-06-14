package com.yang.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yang.bean.Goods;
import com.yang.bean.GoodsType;
import com.yang.service.GoodsService;
import com.yang.service.GoodsTypeService;
import com.yang.utils.DataGridViewResult;
import com.yang.utils.SystemConstant;
import com.yang.vo.GoodsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/admin/goods")
public class GoodsController {
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private GoodsTypeService goodsTypeService;



    @RequestMapping("list")
    @ResponseBody
    public DataGridViewResult list(GoodsVo goodsVo){
        //设置分页信息
        PageHelper.startPage(goodsVo.getPage(),goodsVo.getLimit());
        //调用分页查询的方法
        List<Goods> goodsList = goodsService.findGoodsList(goodsVo);
        System.out.println(goodsList);
        //创建分页对象
        PageInfo<Goods> pageInfo = new PageInfo<>(goodsList);
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }

    /**
     * 添加商品
     * @param goods
     * @return
     */
    @RequestMapping("/addGoods")
    @ResponseBody
    public Map<String,Object> addGoods(Goods goods){
        Map<String, Object> map = new HashMap<String,Object>();
        GoodsType byId = goodsTypeService.findGoodsTypeById(goods.getTypeIdTwo());
        goods.setTypeIdOne(byId.getPid());
        if(goodsService.addGoods(goods)>0){
            map.put(SystemConstant.SUCCESS,true);//成功
            map.put(SystemConstant.MESSAGE,"添加成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"添加失败");
        }
        return map;
    }

    /**
     * 添加商品
     * @param goods
     * @return
     */
    @RequestMapping("/updateGoods")
    @ResponseBody
    public Map<String,Object> updateGoods(Goods goods){
        Map<String, Object> map = new HashMap<String,Object>();
        System.out.println(goods);
        GoodsType byId = goodsTypeService.findGoodsTypeById(goods.getTypeIdTwo());
        goods.setTypeIdOne(byId.getPid());
        if(goodsService.updateGoods(goods)>0){
            map.put(SystemConstant.SUCCESS,true);//成功
            map.put(SystemConstant.MESSAGE,"修改成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"修改失败");
        }
        return map;
    }

    /**
     * 删除商品
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    @ResponseBody
    public Map<String,Object> deleteById(int id){
        Map<String, Object> map = new HashMap<String,Object>();
        if(goodsService.deleteById(id)>0){
            map.put(SystemConstant.SUCCESS,true);//成功
            map.put(SystemConstant.MESSAGE,"删除成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"删除失败");
        }
        return map;
    }


    /**
     * echarts柱状图
     * @return
     */
    @RequestMapping("/findGoodsByBuyNum")
    @ResponseBody
    public Map<String,Object> findGoodsByBuyNum(){
        Map<String, Object> map = new HashMap<String,Object>();
        List<Goods> list = goodsService.findGoodsByBuyNum();
        List<Object> name = new ArrayList<>();
        List<Object> buyNum = new ArrayList<>();
        for (Goods goods : list) {
            name.add(goods.getName());
            buyNum.add(goods.getBuyNum());
        }
        map.put("name",name);
        map.put("buyNum",buyNum);
        return map;
    }
}
