package com.yang.service;

import com.yang.bean.GoodsType;
import com.yang.vo.GoodsTypeVo;

import java.util.List;

public interface GoodsTypeService {
    /**
     * 查询类型
     * @param goodsTypeVo
     * @return
     */
    List<GoodsType> findGoodsTypeList(GoodsTypeVo goodsTypeVo);



    ///**
    // * 查询二级类型列表
    // * @param goodsTypeVo
    // * @return
    // */
    //List<GoodsType> findGoodsTypeList2(GoodsTypeVo goodsTypeVo);

    /**
     * 查询所有二级分类列表
     * @return
     */
    List<GoodsType> findGoodsTypeTwoAll();

    /**
     * 根据id查询一条类型列表
     * @param id
     * @return
     */
    GoodsType findGoodsTypeById(int id);

    /**
     * 添加类型
     * @param goodsType
     * @return
     */
    int addGoodsType(GoodsType goodsType);

    /**
     * 修改类型
     * @param goodsType
     * @return
     */
    int updateGoodsType(GoodsType goodsType);

    /**
     * 删除一级类型
     * @param id
     * @return
     */
    int deleteById(int id);

    /**
     * 删除二级类型
     * @param id
     * @return
     */
    int deleteById2(int id);
}
