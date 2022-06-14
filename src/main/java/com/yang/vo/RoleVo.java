package com.yang.vo;

import com.yang.bean.Role;
import lombok.Data;

@Data
public class RoleVo extends Role {
    //当前页码
    private int page;
    //每页显示数量
    private int limit;
}
