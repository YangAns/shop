package com.yang.service.impl;

import com.yang.bean.GoodsType;
import com.yang.mapper.GoodsTypeMapper;
import com.yang.service.GoodsTypeService;
import com.yang.vo.GoodsTypeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsTypeServiceImpl implements GoodsTypeService {
    @Autowired
    private GoodsTypeMapper goodsTypeMapper;
    @Override
    public List<GoodsType> findGoodsTypeList(GoodsTypeVo goodsTypeVo) {
        if (goodsTypeVo.getPid()!=null){
            return goodsTypeMapper.findGoodsTypeTwoById(goodsTypeVo);
        }else {
            return goodsTypeMapper.findGoodsTypeList(goodsTypeVo);
        }

    }

    @Override
    public List<GoodsType> findGoodsTypeTwoAll() {
        return goodsTypeMapper.findGoodsTypeTwoAll();
    }

    @Override
    public GoodsType findGoodsTypeById(int id) {
        return goodsTypeMapper.findGoodsTypeById(id);
    }

    //@Override
    //public List<GoodsType> findGoodsTypeList2(GoodsTypeVo goodsTypeVo) {
    //    return goodsTypeMapper.findGoodsTypeList2(goodsTypeVo);
    //}

    @Override
    public int addGoodsType(GoodsType goodsType) {
        return goodsTypeMapper.addGoodsType(goodsType);
    }

    @Override
    public int updateGoodsType(GoodsType goodsType) {
        return goodsTypeMapper.updateGoodsType(goodsType);
    }

    @Override
    public int deleteById(int id) {
        return goodsTypeMapper.deleteById(id);
    }

    @Override
    public int deleteById2(int id) {
        return goodsTypeMapper.deleteById2(id);
    }
}
