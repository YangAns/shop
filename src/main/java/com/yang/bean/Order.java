package com.yang.bean;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class Order {
    private Integer id; //主键id
    private String orderCode; //订单编号
    /**
     * 关联用户
     */
    private Integer uid;
    private User user;

    private Date addTime;//添加时间
    private Double orderPrice; //订单总价
    private Integer status;//订单状态
    private List<OrderDetail> orderDetailList;

    private String statusStr;

    //状态字符串
    public String getStatusStr() {
        //判断状态是否为空
        if(status!=null){
            switch (status){
                case -1:
                    statusStr = "已取消";
                    break;
                case 0:
                    statusStr = "待付款";
                    break;
                case 1:
                    statusStr = "待发货";
                    break;
                case 2:
                    statusStr = "待收货";
                    break;
                case 3:
                    statusStr = "待评价";
                    break;
                case 4:
                    statusStr = "已完成";
                    break;
            }
        }
        return statusStr;
    }

    public void setStatusStr(String statusStr) {
        this.statusStr = statusStr;
    }
}
