package com.yang.vo;

import com.yang.bean.Notice;
import lombok.Data;

@Data
public class NoticeVo extends Notice {
    //当前页码
    private int page;
    //每页显示数量
    private int limit;
}
