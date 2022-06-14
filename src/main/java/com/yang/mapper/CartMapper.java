package com.yang.mapper;

import com.yang.bean.Cart;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author yang
 * @date 2021/11/17 - 16:16
 */
public interface CartMapper {
    /**
     * 根据用户查询购物车列表
     * @param uid 用户id
     * @return
     */
    List<Cart> findCartListByUserId(int uid);

    /**
     * 添加购物车
     * @param cart
     * @return
     */
    int addCart(Cart cart);

    /**
     * 删除购物车
     * @param id
     * @return
     */
    int deleteById(int id);

    /**
     * 根据id查询一条购物车数据
     * @param id
     * @return
     */
    Cart findCartById(int id);


    /**
     * 根据商品id，用户id查询购物车数据
     * @param gid
     * @param uid
     * @return
     */
    Cart findCartByGidUid(@Param("gid") int gid, @Param("uid") int uid);


    /**
     * 修改购物车数据
     * @param cart
     * @return
     */
    int updateCart(Cart cart);

    void deleteByGId(Integer gid);
}
