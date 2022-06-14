package com.yang.mapper;

import com.yang.bean.Order;
import com.yang.vo.OrderVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author yang
 * @date 2021/11/18 - 15:16
 */
@Repository
public interface OrderMapper {
    /**
     * 查询订单列表
     * @param orderVo
     * @return
     */
    List<Order> findOrderLIst(OrderVo orderVo);

    /**
     * 删除订单
     * @param id
     * @return
     */
    int deleteById(int id);

    /**
     * 添加订单
     * @param order
     * @return
     */
    int addOrder(Order order);

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
     * @return
     */
    int confirmReceipt(int id);

    /**
     * 前台用户取消订单
     * @param id
     * @return
     */
    int cancelOrder(int id);

    /**
     * 前台用户评价
     * @param id
     * @return
     */
    int finishOrder(int id);

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

    Order findOrderById(@Param("orderId") int orderId);

    Order findOrderByOrderCode(String orderCode);

    int updateStatus(@Param("status") int status, @Param("id") int id);

    List<Integer> findStatusIsNull();
}
