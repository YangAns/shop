<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>确认订单</title>
    <link rel="stylesheet" href="${ctx}/statics/layuimini/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="icon" href="${ctx}/statics/layuimini/images/favicon.ico">
    <link type="text/css" rel="stylesheet" href="${ctx}/statics/front/user/css/style.css">
    <script src="${ctx}/statics/front/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/statics/front/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<body>
<%--头部--%>
<%@include file="../../include/h_top.jsp" %>
<!--导航条-->
<%@include file="../../include/h_navigation.jsp" %>

<div class="width1200 center_yh hidden_yh font14" style="height: 40px;line-height: 40px;">
    <span>当前位置：</span><a href="${ctx}/index.html" class="c_66">首页</a>
    ><a href="#" class="c_66">确认订单</a>
</div>
<form action="${ctx}/order/pay" method="post">
    <input type="hidden" name="orderId" value="${order.id}"/>
    <div class="width1200 hidden_yh center_yh font20">
        确认订单
    </div>
    <div class="width1198 hidden_yh center_yh" style="border: 1px solid #ddd;margin-top: 18px;min-height: 300px;">
        <div class="width100 hidden_yh fQont14" style="height: 32px;line-height: 32px;background: #f0f0f0;text-indent: 21px;
    color: #000;font-weight: 600;border-bottom: 1px solid #ddd;">商品列表
        </div>
        <div class="width100 hidden_yh font14" style="height: 42px;line-height: 42px;border-bottom: 1px solid #ddd;">
            <div class="left_yh tcenter font14" style="width: 486px;">商品信息</div>
            <div class="left_yh tcenter font14" style="width: 175px;">单价</div>
            <div class="left_yh tcenter font14" style="width: 175px;">数量</div>
            <div class="left_yh tcenter font14" style="width: 175px;">金额</div>
        </div>
        <c:forEach var="data" items="${orderDetails}" varStatus="l">
            <div class="speCific" data-id="${data.id}">
                <a href="${ctx}/goodsDetail/${data.goods.id}">
                    <div class="xzSp">
                        <img src="/shop/upload/${data.goods.pic}" alt="">
                        <div class="xzSpIn" style="">
                            <h3 class="font16 c_33 font100" style="margin-bottom: 10px">${data.goods.name}</h3>
                        </div>
                    </div>
                </a>
                <div class="xzJg">
                    ￥<font>${data.goods.price}</font>
                </div>
                <%--<div class="xzSl">--%>
                <%--    <div class="xzSlIn">--%>
                <%--        <input type="text" value="x${data.detailNum}" readonly/>--%>
                <%--    </div>--%>
                <%--</div>--%>
                <div class="xzJg">
                    <font>x${data.detailNum}</font>
                </div>
                <div class="xzXj">
                    ￥<font>${data.detailPrice}</font>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="width1198 center_yh" style="height: 60px;background: #f0f0f0;border: 1px solid #ddd;margin-top: 40px">
        <div class="center_yh hidden_yh" style="width: 1178px;height: 60px;margin-left: 20px;">
            <div class="ifAll"><font>支付方式</font></div>
            <div class="ifDel"><input type="radio" checked value="支付宝支付">支付宝支付</div>
            <div class="relation">收货人：${user.realName==""?user.userName:user.realName}</div>
            <div class="relation">地址：${user.address}</div>

            <div class="sXd">
                <div class="sXd2">合计（不含运费）：￥<font style="color: #cb1c20" id="zjJg">${order.orderPrice}</font></div>
                <input type="submit" class="ifJs" value="提交订单">
            </div>
        </div>
    </div>
</form>
<%@include file="../../include/h_footer.jsp" %>
</body>
</html>



















