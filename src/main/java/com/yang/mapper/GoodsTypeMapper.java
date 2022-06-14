package com.yang.mapper;

import com.yang.bean.GoodsType;
import com.yang.vo.GoodsTypeVo;

import java.util.List;

/**
 * @author yang
 * @date 2021/10/31 - 15:34
 */
public interface GoodsTypeMapper {
    /**
     * 查询一级类型列表
     * @param goodsTypeVo
     * @return
     */
    List<GoodsType> findGoodsTypeList(GoodsTypeVo goodsTypeVo);

    /**
     * 根据pid查询所有二级类型列表
     * @param goodsTypeVo
     * @return
     */
    List<GoodsType> findGoodsTypeTwoById(GoodsTypeVo goodsTypeVo);

    /**
     * 根据id查询一条类型列表
     * @param id
     * @return
     */
    GoodsType findGoodsTypeById(int id);


    /**
     * 查询所有二级分类列表
     * @return
     */
    List<GoodsType> findGoodsTypeTwoAll();


    /**
     * 添加一级类型
     * @param goodsType
     * @return
     */
    int addGoodsType(GoodsType goodsType);


    /**
     * 修改一级类型
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
