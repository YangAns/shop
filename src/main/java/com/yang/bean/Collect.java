package com.yang.bean;

import lombok.Data;

@Data
public class Collect {
    private int id;
    /**
     * 关联商品
     */
    private int gid;
    private Goods goods;
    /**
     * 关联用户
     */
    private int uid;
}
