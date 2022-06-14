package com.yang.config;


import com.alibaba.fastjson.JSON;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.yang.bean.AliPayBean;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Slf4j
@Data
@Configuration
public class AliPayConfig {

    /**日志对象*/
    private final String format = "json";
    /**
     * appId
     */
    @Value("${alipay.appId}")
    private String appId;

    /**
     * 商户私钥
     */
    @Value("${alipay.privateKey}")
    private String privateKey;

    /**
     * 支付宝公钥
     */
    @Value("${alipay.publicKey}")
    private String publicKey;

    /**
     * 服务器异步通知页面路径，需要公网能访问到
     */
    @Value("${alipay.notifyUrl}")
    private String notifyUrl;

    /**
     * 服务器同步通知页面路径，需要公网能访问到
     */
    @Value("${alipay.returnUrl}")
    private String returnUrl;

    /**
     * 签名方式
     */
    @Value("${alipay.signType}")
    private String signType;

    /**
     * 字符编码格式
     */
    @Value("${alipay.charset}")
    private String charset;

    /**
     * 支付宝网关
     */
    @Value("${alipay.gatewayUrl}")
    private String gatewayUrl;

    public String pay(AliPayBean aliPayBean) throws AlipayApiException {

        AlipayClient alipayClient = new DefaultAlipayClient(
                gatewayUrl, appId, privateKey, format, charset, publicKey, signType);

        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(returnUrl);
        alipayRequest.setNotifyUrl(notifyUrl);
        alipayRequest.setBizContent(JSON.toJSONString(aliPayBean));
        log.info("封装请求支付宝付款参数为:{}", JSON.toJSONString(alipayRequest));
        String result = alipayClient.pageExecute(alipayRequest).getBody();
        log.info("请求支付宝付款返回参数为:{}", result);
        return result;
    }
}
