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
<style>
    .example2 ul li img{
        width: 966px;
        height: 490px;
    }
</style>
<body>
<%@include file="../include/h_top.jsp" %>
<!--导航条-->
<div class="width100" style="height: 45px;background: #dd4545;margin-top: 20px;position: relative;z-index: 100;">
    <!--中间的部分-->
    <div class="width1200 center_yh relative_yh" style="height: 45px;">
        <!--列表导航-->
        <div class="left_yh Selected" style="width: 230px;height: 45px;" id="hiddenShow">
            <!--头部的图标-->
            <img src="${ctx}/statics/front/user/images/cd.png" class="left_yh" style="margin-left: 24px;" alt="">
            <span class="block_yh left_yh fff" style="height: 45px;line-height: 44px;margin-left: 10px;">分类</span>
            <!--导航展开部分-->
            <div class="downSlide">
                <c:forEach items="${type}" var="data" varStatus="l">
                    <div class="n1Nav">
                        <font>${data.father.typeName}</font>
                        <img src="${ctx}/statics/front/user/images/jt.png" alt="">
                        <div class="n2Nav">
                            <div class="n3Nav">
                                <h3>${data.father.typeName}</h3>
                                <c:forEach items="${data.children}" var="child" varStatus="ll">
                                    <a href="${ctx}/findFrontGoods?typeIdTwo=${child.id}">${child.typeName}</a>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <!--普通导航-->
        <div class="left_yh font16" id="pageNav">
            <a href="${ctx}/index.html">首页</a>
            <a href="${ctx}/ShowNotice.html">公告</a>
        </div>
    </div>
</div>
<!--轮动广告-->
<div class="width1200 center_yh hidden_yh" style="position: relative;z-index:80;">
    <div class="example2" style="width: 1200px;height: 490px;overflow: hidden;margin-left: 230px;">
        <ul>
            <li><img src="${ctx}/statics/front/images/banner2.jpg" alt=""></li>
            <li><img src="${ctx}/statics/front/images/banner4.jpg" alt=""></li>
            <li><img src="${ctx}/statics/front/images/banner5.jpg" alt=""></li>
        </ul>
    </div>
    <script>
        //渲染轮播
        $(function () {
            $(".example2").luara({width: "966", height: "490", interval: 4500, selected: "seleted", deriction: "left"});
        });
    </script>
</div>

<!--最新上架商品-->
<div class="width1200 center_yh hidden_yh">
    <div class="width100" style="height: 45px;line-height: 45px;border-bottom: 2px solid #dd4545; margin-top: 20px;">
        <font class="left_yh font20">最新上架</font>
    </div>
    <div class="width100 hidden_yh" style="height: 480px;">
        <div class="normalPic">
            <c:forEach items="${newGoods}" var="data" varStatus="l">
                <a href="${ctx}/goodsDetail/${data.id}">
                    <img src="${ctx}/upload/${data.pic}" width="160" height="160" alt="" style="margin:0 auto">
                    <h3 class="yihang c_33 font14 font100" style="text-align: center">${data.name}</h3>
                    <p class="red font14" style="text-align: center">￥${data.price}</p>
                </a>
            </c:forEach>
        </div>
    </div>
</div>

<!--热门商品-->
<div class="width1200 center_yh hidden_yh">
    <div class="width100" style="height: 45px;line-height: 45px;border-bottom: 2px solid #dd4545; margin-top: 20px;">
        <font class="left_yh font20">热门商品</font>
    </div>
    <div class="width100 hidden_yh" style="height: 480px;">
        <div class="normalPic">
            <c:forEach items="${hotGoods}" var="data" varStatus="l">
                <a href="${ctx}/goodsDetail/${data.id}">
                    <img src="${ctx}/upload/${data.pic}" width="160" height="160" alt="" style="margin:0 auto">
                    <h3 class="yihang c_33 font14 font100" style="text-align: center">${data.name}</h3>
                    <p class="red font14" style="text-align: center">￥${data.price}</p>
                </a>
            </c:forEach>
        </div>
    </div>
</div>
<script src="${ctx}/statics/front/layer/layer.js"></script>
<script>
    <%--前台公告弹窗--%>
    function getCookie(name) {
        var cookiefound = false;
        var start = 0;
        var end = 0;
        var cookiestring = document.cookie;
        var i = 0;
        while (i <= cookiestring.length) {
            start = i;
            end = start + name.length;
            if (cookiestring.substring(start, end) == name) {
                cookiefound = true;
                break;
            }
            i++;
        }
        if (cookiefound == true) {
            start = end + 1;
            end = cookiestring.indexOf(";", start);
            if (end < start) {
                end = cookiestring.length;
            }
            return cookiestring.substring(start, end);
        }
        return "";

    }
    function newcookie(id, value, guoqi) {
        var expires = new Date();
        expires.setTime(expires.getTime() + 24 * 60 * 60 * 1 * 1000); //30为天数，可改为任意数字
        var expiryDate = expires.toGMTString();
        document.cookie = id + "=" + value + ";expires=" + expiryDate
    }
    if (getCookie("Alerted") == "") {
        $.ajax({
            url: "${ctx}/newNotice",
            type: "get",
            success: function (result) {
                console.log(result);
                // 页面层
                index = layer.open({
                    type: 1,
                    title: false, //不显示标题栏
                    closeBtn: false,
                    area: ["350", "400px"],
                    shade: 0.8,
                    id: 'LAY_layuipro', //设定一个id，防止重复弹出
                    btn: "我知道了",
                    btnAlign: 'c',
                    moveType: 1,//拖拽模式，0或者1
                    offset: '20px',
                    content: '<div style="padding: 30px; line-height: 22px; background-color: #ff6b3f; color: #ffffff;height: 250px">' +
                        '<p align="center" style="font-weight: bolder;color: #fff;font-size: 20px;margin-bottom: 20px">新公告！！!</p>' +
                        '<p align="center" style="font-weight: bold">' + result.title + '</p><p align="center">' + result.content + '</p>' +
                        '</div>'
                });
            }
        });
        newcookie("Alerted", "yes")
    }

</script>
<%@include file="../include/h_footer.jsp" %>
</body>

</html>



















