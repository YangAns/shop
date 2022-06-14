package com.yang.service;

import com.yang.bean.Order;
import com.yang.vo.OrderVo;

import java.util.List;

/**
 * @author yang
 * @date 2021/11/18 - 15:20
 */
public interface OrderService {
    /**
     * 查询订单列表
     * @param orderVo
     * @return
     */
    List<Order> findOrderLIst(OrderVo orderVo);

    /**
     * 添加订单
     * @param order
     * @return
     */
    int addOrder(Order order);

    /**
     * 删除订单
     * @param id
     * @return
     */
    int deleteById(int id);

    /**
     * 根据用户查询所有订单信息
     * @param uid
     * @return
     */
    List<Order> findOrderListByUid(int uid);

    /**
     * 根据用户查询所有待发货订单信息
     * @param uid
     * @return
     */
    List<Order> findDfhOrderListByUid(int uid);

    /**
     * 根据用户查询所有待付款订单信息
     * @param uid
     * @return
     */
    List<Order> findDfkOrderListByUid(int uid);

    /**
     * 根据用户查询所有待收货订单信息
     * @param uid
     * @return
     */
    List<Order> findDshOrderListByUid(int uid);

    /**
     * 根据用户查询所有待评价订单信息
     * @param uid
     * @return
     */
    List<Order> findYshOrderListByUid(int uid);

    /**
     * 后台管理员发货
     * @param id
     * @return
     */
    int deliverOrder(int id);


    /**
     * 前台用户确认收货
     * @param id
     */
    void confirmReceipt(int id);


    /**
     * 前台用户取消订单
     * @param id
     */
    void cancelOrder(int id);

    /**
     * 前台用户评价完成
     * @param id
     */
    void finishOrder(int id);


    /**
     * 查询总订单数量
     * @return
     */
    int findTotalOrder();

    /**
     * 查询待发货订单数量
     * @return
     */
    int findTotalDeliverOrder();

    //根据订单id查询订单信息
    Order findOrderById(int orderId);

    //根据订单编号查询订单信息
    Order findOrderByOrderCode(String orderCode);

    //修改订单状态
    void updateStatus(int status, int id);

    /**
     * 查询出订单状态为空的所有订单id
     * @return
     */
    List<Integer> findStatusIsNull();
}
