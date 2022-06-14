package com.yang.service;

import com.yang.bean.EmailCode;
import org.apache.ibatis.annotations.Param;

/**
 * @author yang
 * @date 2021/12/11 - 16:52
 */
public interface EmailCodeService {
    EmailCode findEmailCodeByEmail(String email);
    int insetEmailCode(EmailCode emailCode);
    int updateEmailCodeByEmail(@Param("code") String code, @Param("email") String email);
}
