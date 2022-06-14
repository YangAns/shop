package com.yang.service;

import com.alipay.api.AlipayApiException;
import com.yang.bean.AliPayBean;

public interface PayService {

    String aliPay(AliPayBean aliPayBean) throws AlipayApiException;
}

