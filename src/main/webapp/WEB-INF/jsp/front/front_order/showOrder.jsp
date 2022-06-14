<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>我的订单</title>
    <link rel="stylesheet" href="${ctx}/statics/layuimini/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="icon" href="${ctx}/statics/layuimini/images/favicon.ico">
    <link type="text/css" rel="stylesheet" href="${ctx}/statics/front/user/css/style.css">
    <script src="${ctx}/statics/front/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/statics/front/user/js/jquery.luara.0.0.1.min.js"></script>
    <script src="${ctx}/statics/front/layer/layer.js"></script>
    <style>
        .goPay:hover {
            color: red;
            border: 1px;
        }
    </style>

</head>
<body>
<%@include file="../../include/h_top.jsp" %>
<!--导航条-->
<%@include file="../../include/h_navigation.jsp" %>

<div class="width1200 center_yh hidden_yh font14" style="height: 40px;line-height: 40px;">
    <span>当前位置：</span><a href="${ctx}/index.html" class="c_66">首页</a>
    ><a href="#" class="c_66">个人中心</a>
    ><a href="#" class="c_66">我的订单</a>
</div>
<div class="width100 hidden_yh" style="background: #f0f0f0;padding-top: 34px;padding-bottom: 34px;">
    <div class="width1200 hidden_yh center_yh">
        <div id="vipNav">
            <a href="${ctx}/user/userCenter">个人信息</a>
            <a href="${ctx}/order/myOrder" class="on">我的订单</a>
            <a href="${ctx}/collect/myCollect">我的收藏</a>
            <a href="${ctx}/user/updatePwd">修改密码</a>
        </div>
        <div id="vipRight">
            <div style="width: 938px;border:1px solid #ddd;background: #fff;">
                <div class="width100 hidden_yh"
                     style="height: 74px;line-height: 74px;background: #f5f8fa;border-bottom: 1px solid #ddd;"
                     id="navLt">
                    <span class="left_yh font24 width20 tcenter cursor  onorange slect">全部订单（${fn:length(orderList)}）</span>
                    <span class="left_yh font24 width20 tcenter cursor  onorange">待付款（${fn:length(dfkOrderList)}）</span>
                    <span class="left_yh font24 width20 tcenter cursor  onorange">待发货（${fn:length(dfhOrderList)}）</span>
                    <span class="left_yh font24 width20 tcenter cursor  onorange">待收货（${fn:length(dshOrderList)}）</span>
                    <span class="left_yh font24 width20 tcenter cursor  onorange">待评价（${fn:length(yshOrderList)}）</span>
                </div>
                <!--全部订单-->
                <div class="allGoods width100 hidden_yh hhD" style="display: block;">
                    <c:forEach items="${orderList}" var="data">
                        <div class="width100 hidden_yh">
                            <div class="width100 hidden_yh fon20 c_66"
                                 style="background:#faf5f5;text-indent: 47px;height: 50px;line-height: 50px;border-bottom: 1px solid #ddd;">
                                <fmt:formatDate value="${data.addTime}" type="both"/>&nbsp;&nbsp;订单号${data.orderCode}&nbsp;&nbsp;
                                <c:if test="${data.status==-1}">已取消</c:if>
                                <c:if test="${data.status==0}">
                                    <span>待付款</span>
                                    <span style="float:right;margin-right: 80px;padding-top: 15px">
                                        <button style=""><a href="${ctx}/order/pay?orderId=${data.id}"
                                                            style="color: #333333">去支付</a></button>
                                    </span>
                                </c:if>
                                <c:if test="${data.status==1}">待发货</c:if>
                                <c:if test="${data.status==2}">待收货</c:if>
                                <c:if test="${data.status==3}">已收货</c:if>
                                <c:if test="${data.status==4}">已评价</c:if>
                                <c:if test="${data.status==3 || data.status==4}">
                                    <a href="${ctx}/order/fDeleteById?id=${data.id}"
                                       class="c_33 onHover onorange right_yh  del"
                                       style="padding-right: 6px; margin-right: 30px">
                                        删除订单
                                    </a>
                                </c:if>
                            </div>
                            <c:forEach items="${data.orderDetailList}" var="child" varStatus="l">
                                <a href="${ctx}/goodsDetail/${child.goods.id}">
                                    <div style="width: 838px;border-bottom: 1px dashed #ddd;padding-top: 30px;padding-bottom: 30px;"
                                         class="hidden_yh center_yh">
                                        <img src="/shop/upload/${child.goods.pic}" width="100" height="100"
                                             class="left_yh"
                                             style="padding-right: 10px">
                                        <div class="left_yh" style="width: 580px;">
                                            <h3 class="font18 c_33 font100">${child.goods.name}</h3>
                                            <p class="c_33 font100" style="margin-top: 10px;">数量
                                                : ${child.detailNum}</p>
                                            <p class="red" style="margin-top: 10px;">￥${child.goods.price}</p>
                                        </div>
                                        <div class="right_yh">
                                            <c:if test="${data.status==3}">
                                                <a href="javascript:void(0)"
                                                   onclick="publishEva(${child.gid},${data.id})"
                                                   class="onfff block_yh tcenter font16 onHoverr"
                                                   style="margin-top: 10px;padding-right: 6px;">
                                                    去评价
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                            <div style="width: 838px;padding-top:30px;padding-bottom: 30px;"
                                 class="hidden_yh center_yh tleft">
                                <font class="font24">总金额</font>
                                <font class="font24 red">￥${data.orderPrice}</font>
                                <c:if test="${data.status==0}">
                                    <a href="${ctx}/order/cancelOrder?id=${data.id}"
                                       class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        取消订单
                                    </a>
                                </c:if>
                                <c:if test="${data.status==-1}">
                                    <a href="#" class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        交易取消
                                    </a>
                                </c:if>
                                <c:if test="${data.status==1}">
                                    <a href="#" class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        待发货
                                    </a>
                                </c:if>
                                <c:if test="${data.status==2}">
                                    <a href="${ctx}/order/confirmReceipt?id=${data.id}"
                                       class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        确认收货
                                    </a>
                                </c:if>
                                <c:if test="${data.status==3}">
                                    <a href="#" class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        已收货
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty orderList}">
                        <div style="height:100px;color: #333333;padding: 50px;text-align: center"><p>
                            没有符合条件的宝贝，请尝试其他搜索条件。</p></div>
                    </c:if>
                </div>

                <!--待付款-->
                <div class="allGoods width100 hidden_yh hhD" style="display: none;">
                    <c:forEach items="${dfkOrderList}" var="data" varStatus="l">
                        <div class="width100 hidden_yh">
                            <div class="width100 hidden_yh fon20 c_66"
                                 style="background:#faf5f5;text-indent: 47px;height: 50px;line-height: 50px;border-bottom: 1px solid #ddd;">
                                <fmt:formatDate value="${data.addTime}" type="both"/>&nbsp;&nbsp;订单号${data.orderCode}&nbsp;&nbsp;
                                <c:if test="${data.status==0}">
                                    <span>待付款</span>
                                    <span style="float:right;margin-right: 80px;padding-top: 15px">
                                        <button style="color: #ffffff"><a href="${ctx}/order/pay?orderId=${data.id}"
                                                                          style="color: #333333">去支付</a></button>
                                    </span>
                                </c:if>
                                <c:if test="${data.status==1}">待发货</c:if>
                                <c:if test="${data.status==2}">待收货</c:if>
                                <c:if test="${data.status==3}">已收货</c:if>
                                <c:if test="${data.status==4}">已评价</c:if>
                            </div>
                            <c:forEach items="${data.orderDetailList}" var="child" varStatus="l">
                                <a href="${ctx}/goodsDetail/${child.goods.id}">
                                    <div style="width: 838px;border-bottom: 1px dashed #ddd;padding-top: 30px;padding-bottom: 30px;"
                                         class="hidden_yh center_yh">
                                        <img src="/shop/upload/${child.goods.pic}" width="100" height="100"
                                             class="left_yh"
                                             style="padding-right: 10px">
                                        <div class="left_yh" style="width: 580px;">
                                            <h3 class="font18 c_33 font100">${child.goods.name}</h3>
                                            <p class="c_33 font100" style="margin-top: 10px;">数量
                                                : ${child.detailNum}</p>
                                            <p class="red" style="margin-top: 10px;">￥${child.goods.price}</p>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                            <div style="width: 838px;padding-top:30px;padding-bottom: 30px;"
                                 class="hidden_yh center_yh tleft">
                                <font class="font24">总金额</font>
                                <font class="font24 red">￥${data.orderPrice}</font>
                                <c:if test="${data.status==0}">
                                    <a href="${ctx}/order/cancelOrder?id=${data.id}"
                                       class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        取消订单
                                    </a>
                                </c:if>
                                <c:if test="${data.status==1}">
                                    <a href="#" class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        待发货
                                    </a>
                                </c:if>
                                <c:if test="${data.status==2}">
                                    <a href="${ctx}/order/confirmReceipt?id=${data.id}"
                                       class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        确认收货
                                    </a>
                                </c:if>
                                <c:if test="${data.status==3}">
                                    <a href="#" class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        已收货
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty dfkOrderList}">
                        <div style="height:100px;color: #333333;padding: 50px;text-align: center"><p>
                            没有符合条件的宝贝，请尝试其他搜索条件。</p></div>
                    </c:if>
                </div>
                <!--待发货-->
                <div class="allGoods width100 hidden_yh hhD" style="display: none;">
                    <c:forEach items="${dfhOrderList}" var="data" varStatus="l">
                        <div class="width100 hidden_yh">
                            <div class="width100 hidden_yh fon20 c_66"
                                 style="background:#faf5f5;text-indent: 47px;height: 50px;line-height: 50px;border-bottom: 1px solid #ddd;">
                                <fmt:formatDate value="${data.addTime}" type="both"/>&nbsp;&nbsp;订单号${data.orderCode}&nbsp;&nbsp;
                                <c:if test="${data.status==0}">待付款</c:if>
                                <c:if test="${data.status==1}">待发货</c:if>
                                <c:if test="${data.status==2}">待收货</c:if>
                                <c:if test="${data.status==3}">已收货</c:if>
                                <c:if test="${data.status==4}">已评价</c:if>
                            </div>
                            <c:forEach items="${data.orderDetailList}" var="child" varStatus="l">
                                <a href="${ctx}/goodsDetail/${child.goods.id}">
                                    <div style="width: 838px;border-bottom: 1px dashed #ddd;padding-top: 30px;padding-bottom: 30px;"
                                         class="hidden_yh center_yh">
                                        <img src="/shop/upload/${child.goods.pic}" width="100" height="100"
                                             class="left_yh"
                                             style="padding-right: 10px">
                                        <div class="left_yh" style="width: 580px;">
                                            <h3 class="font18 c_33 font100">${child.goods.name}</h3>
                                            <p class="c_33 font100" style="margin-top: 10px;">数量
                                                : ${child.detailNum}</p>
                                            <p class="red" style="margin-top: 10px;">￥${child.goods.price}</p>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                            <div style="width: 838px;padding-top:30px;padding-bottom: 30px;"
                                 class="hidden_yh center_yh tleft">
                                <font class="font24">总金额</font>
                                <font class="font24 red">￥${data.orderPrice}</font>
                                <c:if test="${data.status==0}">
                                    <a href="${ctx}/order/cancelOrder?id=${data.id}"
                                       class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        取消订单
                                    </a>
                                </c:if>
                                <c:if test="${data.status==1}">
                                    <a href="#" class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        待发货
                                    </a>
                                </c:if>
                                <c:if test="${data.status==2}">
                                    <a href="${ctx}/order/confirmReceipt?id=${data.id}"
                                       class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        确认收货
                                    </a>
                                </c:if>
                                <c:if test="${data.status==3}">
                                    <a href="#" class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        已收货
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty dfhOrderList}">
                        <div style="height:100px;color: #333333;padding: 50px;text-align: center"><p>
                            没有符合条件的宝贝，请尝试其他搜索条件。</p></div>
                    </c:if>
                </div>
                <!--待收货-->
                <div class="allGoods width100 hidden_yh hhD" style="display: none;">
                    <c:forEach items="${dshOrderList}" var="data" varStatus="l">
                        <div class="width100 hidden_yh">
                            <div class="width100 hidden_yh fon20 c_66"
                                 style="background:#faf5f5;text-indent: 47px;height: 50px;line-height: 50px;border-bottom: 1px solid #ddd;">
                                <fmt:formatDate value="${data.addTime}" type="both"/>&nbsp;&nbsp;订单号${data.orderCode}&nbsp;&nbsp;
                                <c:if test="${data.status==0}">待付款</c:if>
                                <c:if test="${data.status==1}">待发货</c:if>
                                <c:if test="${data.status==2}">待收货</c:if>
                                <c:if test="${data.status==3}">已收货</c:if>
                                <c:if test="${data.status==4}">已评价</c:if>
                            </div>
                            <c:forEach items="${data.orderDetailList}" var="child" varStatus="l">
                                <a href="${ctx}/goodsDetail/${child.goods.id}">
                                    <div style="width: 838px;border-bottom: 1px dashed #ddd;padding-top: 30px;padding-bottom: 30px;"
                                         class="hidden_yh center_yh">
                                        <img src="/shop/upload/${child.goods.pic}" width="100" height="100"
                                             class="left_yh"
                                             style="padding-right: 10px">
                                        <div class="left_yh" style="width: 580px;">
                                            <h3 class="font18 c_33 font100">${child.goods.name}</h3>
                                            <p class="c_33 font100" style="margin-top: 10px;">数量
                                                : ${child.detailNum}</p>
                                            <p class="red" style="margin-top: 10px;">￥${child.goods.price}</p>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                            <div style="width: 838px;padding-top:30px;padding-bottom: 30px;"
                                 class="hidden_yh center_yh tleft">
                                <font class="font24">总金额</font>
                                <font class="font24 red">￥${data.orderPrice}</font>
                                <c:if test="${data.status==0}">
                                    <a href="${ctx}/order/cancelOrder?id=${data.id}"
                                       class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        取消订单
                                    </a>
                                </c:if>
                                <c:if test="${data.status==1}">
                                    <a href="#" class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        待发货
                                    </a>
                                </c:if>
                                <c:if test="${data.status==2}">
                                    <a href="${ctx}/order/confirmReceipt?id=${data.id}"
                                       class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        确认收货
                                    </a>
                                </c:if>
                                <c:if test="${data.status==3}">
                                    <a href="#" class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        已收货
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty dshOrderList}">
                        <div style="height:100px;color: #333333;padding: 50px;text-align: center"><p>
                            没有符合条件的宝贝，请尝试其他搜索条件。</p></div>
                    </c:if>
                </div>

                <!--已收货-->
                <div class="allGoods width100 hidden_yh hhD" style="display: none;">
                    <c:forEach items="${yshOrderList}" var="data" varStatus="l">
                        <div class="width100 hidden_yh">
                            <div class="width100 hidden_yh fon20 c_66"
                                 style="background:#faf5f5;text-indent: 47px;height: 50px;line-height: 50px;border-bottom: 1px solid #ddd;">
                                <fmt:formatDate value="${data.addTime}" type="both"/>&nbsp;&nbsp;订单号${data.orderCode}&nbsp;&nbsp;
                                <c:if test="${data.status==0}">待付款</c:if>
                                <c:if test="${data.status==1}">待发货</c:if>
                                <c:if test="${data.status==2}">待收货</c:if>
                                <c:if test="${data.status==3}">已收货</c:if>
                                <c:if test="${data.status==4}">已评价</c:if>
                                <c:if test="${data.status==3 || data.status==4}">
                                    <a href="${ctx}/order/fDeleteById?id=${data.id}"
                                       class="c_33 onHover onorange right_yh  del"
                                       style="padding-right: 6px; margin-right: 30px">
                                        删除订单
                                    </a>
                                </c:if>
                            </div>
                            <c:forEach items="${data.orderDetailList}" var="child" varStatus="l">
                                <a href="${ctx}/goodsDetail/${child.goods.id}">
                                    <div style="width: 838px;border-bottom: 1px dashed #ddd;padding-top: 30px;padding-bottom: 30px;"
                                         class="hidden_yh center_yh">
                                        <img src="/shop/upload/${child.goods.pic}" width="100" height="100"
                                             class="left_yh"
                                             style="padding-right: 10px">
                                        <div class="left_yh" style="width: 580px;">
                                            <h3 class="font18 c_33 font100">${child.goods.name}</h3>
                                            <p class="c_33 font100" style="margin-top: 10px;">数量
                                                : ${child.detailNum}</p>
                                            <p class="red" style="margin-top: 10px;">￥${child.goods.price}</p>
                                        </div>
                                        <div class="right_yh">
                                            <c:if test="${data.status==3}">
                                                <a href="javascript:void(0)"
                                                   onclick="publishEva(${child.gid},${data.id})"
                                                   class="onfff block_yh tcenter font16 onHoverr"
                                                   style="margin-top: 10px;padding-right: 6px;">
                                                    去评价
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                            <div style="width: 838px;padding-top:30px;padding-bottom: 30px;"
                                 class="hidden_yh center_yh tleft">
                                <font class="font24">总金额</font>
                                <font class="font24 red">￥${data.orderPrice}</font>
                                <c:if test="${data.status==0}">
                                    <a href="${ctx}/order/cancelOrder?id=${data.id}"
                                       class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        取消订单
                                    </a>
                                </c:if>
                                <c:if test="${data.status==1}">
                                    <a href="#" class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        待发货
                                    </a>
                                </c:if>
                                <c:if test="${data.status==2}">
                                    <a href="${ctx}/order/confirmReceipt?id=${data.id}"
                                       class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        确认收货
                                    </a>
                                </c:if>
                                <c:if test="${data.status==3}">
                                    <a href="#" class="c_33 onHover font20 onorange right_yh"
                                       style="margin-top: 10px;padding-right: 6px;">
                                        已收货
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty yshOrderList}">
                        <div style="height:100px;color: #333333;padding: 50px;text-align: center"><p>
                            没有符合条件的宝贝，请尝试其他搜索条件。</p></div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<%--商品评价页面--%>
<div id="evaData" style="width:600px;padding-top:15px;display:none;">
    <form id="evaForm" class="layui-form">
        <input type="hidden" id="gid" name="gid"/>
        <div class="layui-form-item">
            <label class="layui-form-label" style="padding-top:15px;">评分</label>
            <div class="layui-input-inline">
                <input type="hidden" name="grade" required lay-verify="required" id="grade"/>
                <div id="evaLevel"></div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">评价内容</label>
            <div class="layui-input-inline">
                <textarea rows="8" cols="50" required lay-verify="required" name="content"></textarea>
            </div>
        </div>
        <div class="layui-form-item" align="center">
            <button type="button" class="layui-btn"  id="fromContent"><i
                    class="layui-icon"></i>提交
            </button>
            <button type="reset" class="layui-btn layui-btn-warm"><i
                    class="layui-icon"></i>重置
            </button>
        </div>
    </form>
</div>

<script src="${ctx}/statics/layuimini/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    var index;
    var id;
    function publishEva(gid, orderId) {
        $("#gid").val(gid);
        id = orderId;
        index = layer.open({
            type: 1,
            title: '发表评价',
            shade: 0.4,  //阴影度
            fix: false,
            shadeClose: true,
            maxmin: false,
            offset: ["70px", "400px"],
            area: ['700px;', '400px;'],//窗体大小（宽,高）
            content: $('#evaData'),
        });
    }

    $("#fromContent").click(function () {
        $.post("${ctx}/evaluate/addEvaluate?orderId=" + id, $("#evaForm").serialize(), function (result) {
            if (result.message === "SessionError") {
                layer.msg("请先登录");
                window.location.href = "${ctx}/user/toLogin";
            } else if (result.message === "true") {
                layer.msg('发表评价成功！', {icon: 1, offset: "t"});
                setTimeout(function () {
                    window.location.reload(); //刷新当前页面
                }, 1000);
            } else {
                layer.msg('发表评价失败！,请重试！', {icon: 0, offset: "t"});
            }
            layer.close(index);
        });
    });

    $("#navLt span").click(function () {
        var t = $(this).index();
        $(this).addClass("slect").siblings().removeClass("slect");
        $(".hhD").eq(t).css({display: "block"}).siblings(".hhD").css({display: "none"});
    });

    layui.use(['layer', 'element', 'form', 'rate', 'upload'], function () {
        var $ = layui.jquery,
            form = layui.form,
            rate = layui.rate,
            upload = layui.upload;
        var ins1 = rate.render({
            elem: '#evaLevel',  //绑定元素
            theme: '#FF5722',
            choose: function (value) {
                $("#grade").val(value);
            }
        });
    });
</script>

<%@include file="../../include/h_footer.jsp" %>
</body>
</html>













