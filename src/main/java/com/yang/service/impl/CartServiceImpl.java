package com.yang.service.impl;

import com.yang.bean.Cart;
import com.yang.mapper.CartMapper;
import com.yang.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author yang
 * @date 2021/11/17 - 16:59
 */
@Service
public class CartServiceImpl implements CartService {
    @Autowired
    private CartMapper cartMapper;

    @Override
    public List<Cart> findCartListByUserId(int uid) {
        return cartMapper.findCartListByUserId(uid);
    }

    @Override
    public int addCart(Cart cart) {
        Cart cartByGid = cartMapper.findCartByGidUid(cart.getGid(),cart.getUid());
        if(cartByGid!=null){
            int num = cart.getNum()+cartByGid.getNum();
            cartByGid.setNum(num);
            return cartMapper.updateCart(cartByGid);
        }else{
            return cartMapper.addCart(cart);
        }
    }
    @Override
    public int deleteById(int id) {
        return cartMapper.deleteById(id);
    }

    @Override
    public Cart findCartById(int id) {
        return cartMapper.findCartById(id);
    }

    @Override
    public void deleteByGId(Integer gid) {
        cartMapper.deleteByGId(gid);
    }

}
