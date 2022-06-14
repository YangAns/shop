package com.yang.mapper;

import com.yang.bean.Goods;
import com.yang.vo.GoodsVo;

import java.util.List;

public interface GoodsMapper {
    /**
     * 查询商品列表
     * @param goodsVo
     * @return
     */
    List<Goods> findGoodsList(GoodsVo goodsVo);


    /**
     * 添加商品
     * @param goods
     * @return
     */
    int addGoods(Goods goods);

    /**
     * 修改商品
     * @param goods
     * @return
     */
    int updateGoods(Goods goods);


    /**
     * 删除商品
     * @param id
     * @return
     */
    int deleteById(int id);


    //-------------前台功能---------------
    /**
     * 查询所有促销商品
     * @return
     */
    List<Goods> findSaleGoodsList();

    /**
     * 查询所有热门商品
     * @return
     */
    List<Goods> findHotGoodsList();


    /**
     * 查询最新上架商品
     * @return
     */
    List<Goods> findNewGoodsList();

    /**
     * 前台商品模糊查询
     * @return
     */
    List<Goods> findFrontGoods(Goods goods);

    /**
     * 根据id查询一条商品
     * @param id
     * @return
     */
    Goods findGoodsById(int id);


    /**
     * 查询所有根据购买数量排序的商品
     * @return
     */
    List<Goods> findGoodsByBuyNum();


    /**
     * 查询总商品数量
     * @return
     */
    int findTotalGoods();
}
