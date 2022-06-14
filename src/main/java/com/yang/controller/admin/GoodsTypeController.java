package com.yang.controller.admin;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yang.bean.GoodsType;
import com.yang.service.GoodsTypeService;
import com.yang.utils.DataGridViewResult;
import com.yang.utils.SystemConstant;
import com.yang.vo.GoodsTypeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/goodstype")
public class GoodsTypeController {
    @Autowired
    private GoodsTypeService goodsTypeService;

    /**
     * 类型列表
     * @param goodsTypeVo
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public DataGridViewResult list(GoodsTypeVo goodsTypeVo){
        //设置分页信息
        PageHelper.startPage(goodsTypeVo.getPage(),goodsTypeVo.getLimit());
        //调用分页查询的方法
        List<GoodsType> goodsTypeList = goodsTypeService.findGoodsTypeList(goodsTypeVo);
        //创建分页对象
        PageInfo<GoodsType> pageInfo = new PageInfo<GoodsType>(goodsTypeList);
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }

    //@RequestMapping("/list2")
    //@ResponseBody
    //public DataGridViewResult list2(GoodsTypeVo goodsTypeVo){
    //    System.out.println(goodsTypeVo.getPid());
    //    //设置分页信息
    //    PageHelper.startPage(goodsTypeVo.getPage(),goodsTypeVo.getLimit());
    //    //调用分页查询的方法
    //    List<GoodsType> goodsTypeList = goodsTypeService.findGoodsTypeList2(goodsTypeVo);
    //    //创建分页对象
    //    PageInfo<GoodsType> pageInfo = new PageInfo<GoodsType>(goodsTypeList);
    //    return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    //}


    /**
     * 查询所有一级商品类型
     * @return
     */
    @RequestMapping("/findOneAll")
    @ResponseBody
    public String findAll(GoodsTypeVo goodsTypeVo){
        return JSON.toJSONString(goodsTypeService.findGoodsTypeList(goodsTypeVo));
    }

    /**
     * 查询所有二级商品类型
     * @return
     */
    @RequestMapping("/findTwoAll")
    @ResponseBody
    public String findTwoAll(){
        return JSON.toJSONString(goodsTypeService.findGoodsTypeTwoAll());
    }

    /**
     * 添加类型
     * @param goodsType
     * @return
     */
    @RequestMapping("/addGoodsType")
    @ResponseBody
    public Map<String,Object> addGoodsType(GoodsType goodsType){
        Map<String, Object> map = new HashMap<String,Object>();
        if(goodsTypeService.addGoodsType(goodsType)>0){
            map.put(SystemConstant.SUCCESS,true);//成功
            map.put(SystemConstant.MESSAGE,"添加成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"添加失败");
        }
        return map;
    }

    /**
     * 修改类型
     * @param goodsType
     * @return
     */
    @RequestMapping("/updateGoodsType")
    @ResponseBody
    public Map<String,Object> updateGoodsType(GoodsType goodsType){
        Map<String, Object> map = new HashMap<String,Object>();
        if(goodsTypeService.updateGoodsType(goodsType)>0){
            map.put(SystemConstant.SUCCESS,true);//成功
            map.put(SystemConstant.MESSAGE,"修改成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"修改失败");
        }
        return map;
    }

    /**
     * 删除类型
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    @ResponseBody
    public Map<String,Object> deleteById(int id){
        Map<String, Object> map = new HashMap<String,Object>();
        goodsTypeService.deleteById2(id);
        if(goodsTypeService.deleteById(id)>0){
            map.put(SystemConstant.SUCCESS,true);//成功
            map.put(SystemConstant.MESSAGE,"删除成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"删除失败");
        }
        return map;
    }
}
