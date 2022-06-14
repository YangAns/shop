package com.yang.service;

import com.yang.bean.Cart;

import java.util.List;

/**
 * @author yang
 * @date 2021/11/17 - 16:58
 */
public interface CartService {
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

    void deleteByGId(Integer gid);
}
