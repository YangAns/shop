package com.yang.utils;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 菜单节点工具类
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MenuNode {
    private int id;//菜单编号
    private int pid;//父级菜单编号
    private String title;//菜单名称
    private String href;//链接地址
    private int spread;//是否展开
    private String target;//打开方式
    private String icon;//菜单图标
    private List<MenuNode> child;//子菜单集合列表
}
