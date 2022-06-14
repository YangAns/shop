package com.yang.bean;
import lombok.Data;

@Data
public class User {
    private Integer id;
    private String userName;
    private String password;
    private String phone;
    private String realName;
    private String sex;
    private String address;
    private String email;
    private String pic;

    /**
     * 用户状态
     * 0表示禁用
     * 1表示正常
     * -1表示删除
     */
    private Integer status;
}
