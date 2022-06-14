package com.yang.service.impl;

import com.yang.bean.Goods;
import com.yang.mapper.GoodsMapper;
import com.yang.service.GoodsService;
import com.yang.vo.GoodsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsServiceImpl implements GoodsService {
    @Autowired
    private GoodsMapper goodsMapper;
    @Override
    public List<Goods> findGoodsList(GoodsVo goodsVo) {
        return goodsMapper.findGoodsList(goodsVo);
    }

    @Override
    public int addGoods(Goods goods) {
        goods.setBuyNum(0);
        goods.setCollectNum(0);
        return goodsMapper.addGoods(goods);
    }

    @Override
    public int updateGoods(Goods goods) {
        return goodsMapper.updateGoods(goods);
    }

    @Override
    public int deleteById(int id) {
        return goodsMapper.deleteById(id);
    }

    @Override
    public List<Goods> findSaleGoodsList() {
        return goodsMapper.findSaleGoodsList();
    }

    @Override
    public List<Goods> findHotGoodsList() {
        return goodsMapper.findHotGoodsList();
    }

    @Override
    public List<Goods> findNewGoodsList() {
        return goodsMapper.findNewGoodsList();
    }

    @Override
    public List<Goods> findFrontGoods(Goods goods) {
        return goodsMapper.findFrontGoods(goods);
    }

    @Override
    public Goods findGoodsById(int id) {
        return goodsMapper.findGoodsById(id);
    }

    @Override
    public List<Goods> findGoodsByBuyNum() {
        return goodsMapper.findGoodsByBuyNum();
    }

    @Override
    public int findTotalGoods() {
        return goodsMapper.findTotalGoods();
    }
}
