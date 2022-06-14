<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>YangAns乐享数码</title>
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
    <span>当前位置：</span><a href="${ctx}/index.html" class="c_66">首页</a>><a href="#" class="c_66">商品列表</a>
</div>
<div class="width1198 center_yh" style="height: 35px;background: #f0f0f0; border: 1px solid #ddd;margin-top:25px;">
    <a href="${ctx}/findFrontGoods?typeIdTwo=${goods.typeIdTwo}" class="mR">默认</a>
    <a href="${ctx}/findFrontGoods?price=1&typeIdTwo=${goods.typeIdTwo}" class="mR">
        价格
        <img src="${ctx}/statics/front/user/images/gg.png" alt="">
    </a>
    <a href="${ctx}/findFrontGoods?buyNum=1&typeIdTwo=${goods.typeIdTwo}" class="mR">
        销量
        <img src="${ctx}/statics/front/user/images/gg.png" alt="">
    </a>

</div>
<!--商品列表-->
<div class="width1200 center_yh hidden_yh" style="margin-top: 25px;">
    <ul class="listSs">
        <c:forEach items="${frontGoods}" var="data" varStatus="l">
            <li>
                <a href="${ctx}/goodsDetail/${data.id}" class="bjK">
                    <img src="upload/${data.pic}" alt="">
                </a>
                <h3 class="spName">${data.name}</h3>
                <p class="center_yh block_yh hidden_yh" style="width: 202px;">
                    <font class="left_yh red font16">￥${data.price}</font>
                </p>
            </li>
        </c:forEach>
        <c:if test="${empty frontGoods}">
            <div style="text-align: center;color: #bababa">该商品还未上架</div>
        </c:if>
    </ul>
</div>
<div id="navs">
</div>
<script>
</script>
<%@include file="../../include/h_footer.jsp" %>
</body>
</html>



















