package com.yang.service.impl;

import com.yang.bean.EmailCode;
import com.yang.mapper.EmailCodeMapper;
import com.yang.service.EmailCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author yang
 * @date 2021/12/11 - 16:52
 */
@Service
public class EmailCodeServiceImpl implements EmailCodeService {
    @Autowired
    private EmailCodeMapper emailCodeMapper;
    @Override
    public EmailCode findEmailCodeByEmail(String email) {
        return emailCodeMapper.findEmailCodeByEmail(email);
    }

    @Override
    public int insetEmailCode(EmailCode emailCode) {
        return emailCodeMapper.insetEmailCode(emailCode);
    }

    @Override
    public int updateEmailCodeByEmail(String code, String email) {
        return emailCodeMapper.updateEmailCodeByEmail(code,email);
    }
}
