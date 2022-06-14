package com.yang.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class SendMail {
    @Autowired
    private JavaMailSender javaMailSender;//在spring中配置的邮件发送的bean
    public void sendCode(String toEmail, String code) throws Exception {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setSubject("YangAns乐享数码商城邮件服务"); //邮件主题
        mailMessage.setText("您的验证码是:" + code);  //邮件内容
        mailMessage.setTo(toEmail); //收件人
        mailMessage.setFrom("914405257@qq.com"); //发件人
        javaMailSender.send(mailMessage);
    }
}