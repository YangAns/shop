package com.yang.service;

import com.yang.bean.OrderDetail;

import java.util.List;

public interface OrderDetailService {
    /**
     * 添加订单详情
     * @param orderDetail
     * @return
     */
    int addOrderDetail(OrderDetail orderDetail);

    /**
     * 根据订单号查询订单详情列表
     * @param id
     * @return
     */
    List<OrderDetail> findOrderDetailListByOrderId(int id);

    /**
     * 删除订单详情
     * @param orderId
     * @return
     */
    int deleteById(int orderId);
}
