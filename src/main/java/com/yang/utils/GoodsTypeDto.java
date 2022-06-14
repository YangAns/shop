package com.yang.utils;

import com.yang.bean.GoodsType;
import lombok.Data;

import java.util.List;

@Data
public class GoodsTypeDto {
    private GoodsType father;
    private List<GoodsType> children;
}
