package com.yang.service.impl;

import com.yang.bean.Order;
import com.yang.mapper.OrderDetailMapper;
import com.yang.mapper.OrderMapper;
import com.yang.service.OrderService;
import com.yang.vo.OrderVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private OrderDetailMapper orderDetailMapper;
    @Override
    public List<Order> findOrderLIst(OrderVo orderVo) {
        return orderMapper.findOrderLIst(orderVo);
    }

    @Override
    public int addOrder(Order order) {
        return orderMapper.addOrder(order);
    }

    @Override
    public int deleteById(int id) {
        orderDetailMapper.deleteById(id);
        return orderMapper.deleteById(id);
    }

    @Override
    public List<Order> findOrderListByUid(int uid) {
        return orderMapper.findOrderListByUid(uid);
    }

    @Override
    public List<Order> findDfhOrderListByUid(int uid) {
        return orderMapper.findDfhOrderListByUid(uid);
    }

    @Override
    public List<Order> findDfkOrderListByUid(int uid) {
        return orderMapper.findDfkOrderListByUid(uid);
    }

    @Override
    public List<Order> findDshOrderListByUid(int uid) {
        return orderMapper.findDshOrderListByUid(uid);
    }

    @Override
    public List<Order> findYshOrderListByUid(int uid) {
        return orderMapper.findYshOrderListByUid(uid);
    }

    @Override
    public int deliverOrder(int id) {
        return orderMapper.deliverOrder(id);
    }

    @Override
    public void confirmReceipt(int id) {
        orderMapper.confirmReceipt(id);
    }

    @Override
    public void cancelOrder(int id) {
        orderMapper.cancelOrder(id);
    }

    @Override
    public void finishOrder(int id) {
        orderMapper.finishOrder(id);
    }

    @Override
    public int findTotalOrder() {
        return orderMapper.findTotalOrder();
    }

    @Override
    public int findTotalDeliverOrder() {
        return orderMapper.findTotalDeliverOrder();
    }

    @Override
    public Order findOrderById(int orderId) {
        return orderMapper.findOrderById(orderId);
    }

    @Override
    public Order findOrderByOrderCode(String orderCode) {
        return orderMapper.findOrderByOrderCode(orderCode);
    }

    @Override
    public void updateStatus(int status, int id) {
        orderMapper.updateStatus(status, id);
    }

    @Override
    public List<Integer> findStatusIsNull() {
        return orderMapper.findStatusIsNull();
    }
}
