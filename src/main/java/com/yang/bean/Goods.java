package com.yang.bean;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Data
public class Goods {
    private Integer id;//主键
    private String name;//商品名称
    private double price; //价格
    private Integer num; //库存
    private String pic;//商品图片

    /**
     *一级类别
     */
    private Integer typeIdOne;
    private GoodsType typeOne;

    /**
     * 二级类别
     */
    private Integer typeIdTwo;
    private GoodsType typeTwo;

    private Integer collectNum; //收藏数量
    private Integer buyNum;//购买数量
    private Integer discount; //折扣
    private String details; //描述
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date addTime; //添加时间

    /**
     * 关联商品评价
     */
    private List<Evaluate> evaluateList;
}
