package com.yang.vo;

import com.yang.bean.Admin;
import lombok.Data;

@Data
public class AdminVo extends Admin {
    //当前页码
    private int page;
    //每页显示数量
    private int limit;
}
