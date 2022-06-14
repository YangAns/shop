package com.yang.mapper;


import com.yang.bean.EmailCode;
import org.apache.ibatis.annotations.Param;

public interface EmailCodeMapper {
    EmailCode findEmailCodeByEmail(String email);
    int insetEmailCode(EmailCode emailCode);
    int updateEmailCodeByEmail(@Param("code") String code, @Param("email") String email);
}
