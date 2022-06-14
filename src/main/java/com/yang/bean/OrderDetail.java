package com.yang.bean;

import lombok.Data;

@Data
public class OrderDetail {
    private Integer id; //主键
    /**
     * 关联商品
     */
    private Integer gid;
    private Goods goods;

    /**
     * 关联订单
     */
    private Integer orderId;//订单编号
    private Order order;

    private Integer detailNum;//数量
    private Double detailPrice;//小计
    private Integer status;//状态
}
