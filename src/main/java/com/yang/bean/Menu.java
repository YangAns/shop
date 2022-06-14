package com.yang.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Menu {
    private Integer id;  //菜单id
    private Integer pid; //父id
    private String title; //菜单名称
    private String href; //菜单链接
    private Integer spread; //是否展开
    private String target; //打开方式
    private String icon; //菜单图标样式
}
