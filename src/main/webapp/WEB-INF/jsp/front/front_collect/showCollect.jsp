<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>我的收藏</title>
    <link rel="stylesheet" href="${ctx}/statics/layuimini/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="icon" href="${ctx}/statics/layuimini/images/favicon.ico">
    <link type="text/css" rel="stylesheet" href="${ctx}/statics/front/user/css/style.css">
    <script src="${ctx}/statics/front/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/statics/front/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<body>
<%@include file="../../include/h_top.jsp" %>
<!--导航条-->
<%@include file="../../include/h_navigation.jsp" %>
<div class="width1200 center_yh hidden_yh font14" style="height: 40px;line-height: 40px;">
    <span>当前位置：</span><a href="${ctx}/index.html" class="c_66">首页</a>
    ><a href="#" class="c_66">个人中心</a>
    ><a href="#" class="c_66">商品收藏</a>
</div>
<div class="width100 hidden_yh" style="background: #f0f0f0;padding-top: 34px;padding-bottom: 34px;">
    <div class="width1200 hidden_yh center_yh">
        <div id="vipNav">
            <a href="${ctx}/user/userCenter">个人信息</a>
            <a href="${ctx}/order/myOrder">我的订单</a>
            <a href="${ctx}/collect/myCollect" class="on">我的收藏</a>
            <a href="${ctx}/user/updatePwd">修改密码</a>
        </div>
        <div id="vipRight">
            <div class="hidden_yh bj_fff" style="width: 938px;border: 1px solid #ddd;">
                <div class="width100 font24" style="height: 60px;line-height: 60px;text-indent: 50px;background: #f5f8fa;border-bottom: 1px solid #ddd;">
                    最近收藏
                </div>
                <div class="hidden_yh" style="padding: 20px;width: 898px;">
                    <c:forEach items="${collectList}" var="data" varStatus="l" >
                        <a href="${ctx}/goodsDetail/${data.gid}">
                            <div class="width100 hidden_yh" style="border-bottom: 1px dashed #ddd;padding-top: 10px;padding-bottom: 10px;">
                                <img src="/shop/upload/${data.goods.pic}" width="100" height="100" class="left_yh" style="margin-right: 15px;">
                                <div class="left_yh" style="width: 580px;margin-top: 20px">
                                    <h3 class="font18 c_33 font100">${data.goods.name}</h3>
                                    <p class="red" style="margin-top: 10px">￥${data.goods.price}</p>
                                </div>
                                <div class="right_yh">
                                    <a href="${ctx}/collect/deleteById?id=${data.id}" class="onfff block_yh tcenter font16" style="margin-top: 64px;padding: 6px">
                                        取消收藏
                                    </a>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                    <c:if test="${ empty collectList }">
                        <p>暂无收藏</p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../../include/h_footer.jsp" %>
</body>
</html>



















