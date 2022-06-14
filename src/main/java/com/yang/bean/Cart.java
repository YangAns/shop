package com.yang.bean;

import lombok.Data;

@Data
public class Cart {
    private Integer id;
    /**
     * 商品
     */
    private Integer gid;
    private Goods goods;

    /**
     *用户
     */
    private Integer uid;
    private User user;

    private Integer num;
    private Double price;
    private Double totalPrice;
}
