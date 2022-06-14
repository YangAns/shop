package com.yang.controller.front;

import com.yang.bean.OrderDetail;
import com.yang.service.OrderDetailService;
import com.yang.utils.DataGridViewResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/orderDetail")
public class OrderDetailController {
    @Autowired
    private OrderDetailService orderDetailService;


    @RequestMapping("list")
    @ResponseBody
    public DataGridViewResult list(int orderId){
        //调用分页查询的方法
        List<OrderDetail> orderDetailList = orderDetailService.findOrderDetailListByOrderId(orderId);
        return new DataGridViewResult(orderDetailList);
    }
}
