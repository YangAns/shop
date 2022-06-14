package com.yang.vo;

import com.yang.bean.Goods;
import lombok.Data;

@Data
public class GoodsVo extends Goods {
    //当前页码
    private int page;
    //每页显示数量
    private int limit;
}
