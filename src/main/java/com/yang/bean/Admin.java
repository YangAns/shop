package com.yang.bean;

import lombok.Data;

import java.util.Date;

@Data
public class Admin {
    private Integer id; //主键id
    private String loginName;//登录名
    private String password;//密码
    private String realName;//真实姓名
    private String phone;  //电话
    private Date createDate;
    private Integer status;
}
