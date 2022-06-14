package com.yang.vo;

import com.yang.bean.Evaluate;
import lombok.Data;

@Data
public class EvaluateVo extends Evaluate {
    //当前页码
    private int page;
    //每页显示数量
    private int limit;
}
