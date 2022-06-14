package com.yang.vo;

import com.yang.bean.Order;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class OrderVo extends Order {
    //当前页码
    private int page;
    //每页显示数量
    private int limit;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;//开始日期
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;//结束日期
}
