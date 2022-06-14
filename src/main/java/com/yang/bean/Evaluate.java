package com.yang.bean;

import lombok.Data;

import java.util.Date;

@Data
public class Evaluate {
    private Integer id;
    /**
     * 关联用户
     */
    private Integer uid;
    private User user;

    /**
     * 关联商品
     */
    private Integer gid;
    private Goods goods;

    private Integer grade;
    private String content;
    private Date addTime;
}

