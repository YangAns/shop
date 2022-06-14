package com.yang.service.impl;

import com.yang.bean.OrderDetail;
import com.yang.mapper.OrderDetailMapper;
import com.yang.service.OrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderDetailServiceImpl implements OrderDetailService {
    @Autowired
    private OrderDetailMapper orderDetailMapper;
    @Override
    public int addOrderDetail(OrderDetail orderDetail) {
        return orderDetailMapper.addOrderDetail(orderDetail);
    }

    @Override
    public List<OrderDetail> findOrderDetailListByOrderId(int id) {
        return orderDetailMapper.findOrderDetailListByOrderId(id);
    }

    @Override
    public int deleteById(int orderId) {
        return orderDetailMapper.deleteById(orderId);
    }

}
