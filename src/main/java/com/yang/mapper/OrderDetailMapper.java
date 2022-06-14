package com.yang.mapper;


import com.yang.bean.OrderDetail;

import java.util.List;

public interface OrderDetailMapper {
    /**
     * 根据订单号查询订单详情列表
     * @param id
     * @return
     */
    List<OrderDetail> findOrderDetailListByOrderId(int id);

    /**
     * 添加订单详情
     * @param orderDetail
     * @return
     */
    int addOrderDetail(OrderDetail orderDetail);

    /**
     * 删除订单详情
     * @param orderId
     * @return
     */
    int deleteById(int orderId);

    OrderDetail findOrderDetailByOrderId(int orderId);
}
