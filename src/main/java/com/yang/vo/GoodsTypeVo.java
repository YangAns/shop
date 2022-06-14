package com.yang.vo;

import com.yang.bean.GoodsType;
import lombok.Data;

@Data
public class GoodsTypeVo extends GoodsType {
    //当前页码
    private int page;
    //每页显示数量
    private int limit;
}
