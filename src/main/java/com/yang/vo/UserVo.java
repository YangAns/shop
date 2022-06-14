package com.yang.vo;

import com.yang.bean.User;
import lombok.Data;

@Data
public class UserVo extends User {
    //当前页码
    private int page;
    //每页显示数量
    private int limit;
}
