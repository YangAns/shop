<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>商品详情</title>
    <link rel="stylesheet" href="${ctx}/statics/layuimini/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="icon" href="${ctx}/statics/layuimini/images/favicon.ico">
    <link type="text/css" rel="stylesheet" href="${ctx}/statics/front/user/css/style.css">
    <script src="${ctx}/statics/front/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/statics/front/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<style>
    * {
        margin: 0;
        padding: 0;
    }

    .box {
        float: left;
        text-align: center;
        width: 350px;
        margin: 10px;
        position: relative;
    }

    .big {
        width: 400px;
        height: 400px;
        position: absolute;
        top: 0;
        left: 360px;
        /*border: 1px solid #ccc;*/
        overflow: hidden;
        display: none;
    }

    .mask {
        width: 175px;
        height: 175px;
        background: rgba(255, 255, 0, 0.4);
        position: absolute;
        top: 0;
        left: 0;
        cursor: move;
        display: none;
    }

    .small {
        position: relative;
    }

    .box img {
        vertical-align: top;
    }

    #bigBox img {
        position: absolute;
    }

    img.error {
        display: inline-block;
        transform: scale(1);
        content: '';
        color: transparent;
    }

    img.error::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background: #f5f5f5 url(${ctx}/statics/front/user/images/break.png) no-repeat center / 50% 50%;
    }

    img.error::after {
        content: attr(alt);
        position: absolute;
        left: 0;
        bottom: 0;
        width: 100%;
        line-height: 2;
        background-color: rgba(0, 0, 0, .5);
        color: white;
        font-size: 12px;
        text-align: center;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

</style>
<body>
<%@include file="../../include/h_top.jsp" %>
<!--导航条-->
<%@include file="../../include/h_navigation.jsp" %>
<div class="width1200 center_yh hidden_yh font14" style="height: 40px;line-height: 40px;">
    <span>当前位置：</span><a href="${ctx}/index.html" class="c_66">首页</a>
    ><a href="#" class="c_66">商品列表</a>
    ><a href="#" class="c_66">详情</a>
</div>
<div class="width1198 center_yh" style="height: 420px;">
    <div class="left_yh" style="width: 350px;height: 420px;">
        <input type="hidden" id="id" value="${goods.id}">
        <div id="box" class="box">
            <div id="smallBox" class="small ">
                <img src="${ctx}/upload/${goods.pic}" alt="" height="350" width="350">
                <div id="mask" class="mask"></div>
            </div>
            <div id="bigBox" class="big">
                <img src="${ctx}/upload/${goods.pic}" alt="" id="bigPic">
            </div>
        </div>
    </div>
    <div class="left_yh" style="width: 486px;height: 420px;margin-left: 42px;margin-top: 30px">
        <h3 class="font20 font100">${goods.name}</h3>
        <p class="font16 c_66" style="margin-top:25px;">
            <font style="margin-right: 20px;">价格：</font>
            <font class="red font20">
                ￥${goods.price}
            </font>
        </p>
        <p class="font16 c_66" style="margin-top:25px;">
            <font style="margin-right: 20px;">库存：</font>
            <font class="font14 c_99">
                ${goods.num}
            </font>
        </p>

        <p class="font16 c_66" style="margin-top:25px;">
            <font style="margin-right: 20px;">销量：</font>
            <font class="font14 c_99">
                ${goods.buyNum}
            </font>
        </p>
        <c:if test="${goods.discount!=null}">
            <p class="font16 c_66" style="margin-top:25px;">
                <font style="margin-right: 20px;">促销：</font>
                <font>
                        ${goods.discount}
                    <span style="color: red">折</span>
                </font>
            </p>
        </c:if>
        <p class="font16 c_66 likeColor" style="margin-top: 25px;">
            <font style="margin-right: 20px;">数量：</font>
            <a href="javascript:void(0)" id="min_s">-</a>
            <input type="text" value="1" readonly id="t_a">
            <a href="javascript:void(0)" id="add_s">+</a>
            <%--<font class="font14 c_99" style="margin-left: 20px;">库存:${goods.num}</font>--%>
            <script>
                var tr = $("#t_a").val();
                $("#min_s").click(function () {
                    tr--;
                    if (tr < 1) {
                        $("#t_a").val(1);
                        tr = 1;
                    } else {
                        $("#t_a").val(tr);
                    }
                });
                $("#add_s").click(function () {
                    tr++;
                    if (tr===${goods.num}) {
                        $("#t_a").val(${goods.num});
                        tr = 1;
                    } else {
                        $("#t_a").val(tr);
                    }
                });
            </script>
        </p>
        <div class="buyFor">
            <a href="javascript:void(0)" class="mstBuy">收藏</a>
            <a href="javascript:void(0)" class="addCar">加入购物车</a>
        </div>
    </div>
</div>
<div class="width1200 hidden_yh center_yh" style="margin-top: 40px;">
    <div class="right_yh" style="width: 1200px;">
        <div class="hidden_yh" id="spXqpj">
            <a href="javascript:void(0)" class="on">商品详情</a>
            <a href="javascript:void(0)">商品评价</a>
        </div>

        <div class="width100 hidden_yh">
            <div id="spDetail">
                ${goods.details}
            </div>
            <%--商品评价列表--%>
            <div id="spPj">
                <div class="width100 hidden_yh" style="padding-bottom: 20px;border-bottom: 1px dashed #ddd;margin-bottom: 10px";>
                    <c:forEach items="${goods.evaluateList}" var="data" varStatus="l">
                        <div style="width: 790px;float:right;overflow: hidden;margin-top: 20px;">
                            <img src="${ctx}/upload/${data.user.pic}" style="width: 40px;height: 40px;border-radius: 50%;float:left;border:1px solid #ddd;margin-top: 20px;margin-right: 30px;" onerror="this.classList.add('error');"/>
                            <h3 class="font16 c_33 font100" style="color: red;font-weight: bold;">${data.user.userName}</h3>

                            <div style="height:30px;width:150px;float:right;" id="evaStar${data.id }" class="evaStar"></div>

                            <p class="font14 c_99" style="margin-top: 6px;">
                                <fmt:formatDate value="${data.addTime}" pattern="yyyy-MM-dd"/>
                            </p>
                            <p class="font16 c_33" style="margin-top: 6px;">
                                    ${data.content}
                            </p>

                            <div class="width100 hidden_yh" style="padding-bottom: 20px;border-bottom: 1px solid #ddd;margin-bottom: 10px;"></div>
                        </div>
                    </c:forEach>
                    <c:if test="${ empty goods.evaluateList }">
                        <h3>暂无评价</h3>
                    </c:if>
                </div>

            </div>
        </div>
    </div>
</div>
<script src="${ctx}/statics/front/layer/layer.js"></script>
<script src="${ctx}/statics/layuimini/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>

    //评价与详情切换样式
    $("#spXqpj a").click(function () {
        $(this).addClass("on").siblings().removeClass("on");
    });
    $("#spXqpj a").eq(0).click(function () {
        $("#spDetail").css({display: "block"}).siblings().css({display: "none"});
    });
    $("#spXqpj a").eq(1).click(function () {
        $("#spPj").css({display: "block"}).siblings().css({display: "none"});
    });

    //渲染评价等级
    layui.use(['layer','rate'], function() {
        var rate = layui.rate;
        rate.render({
            elem: '.evaStar',  //绑定元素
            theme: '#FF5722',
            readonly:true,
        });

        var arr=[];
        <c:forEach items="${goods.evaluateList}" var="data">
        arr.push('${data.id}${data.grade}');
        </c:forEach>
        for(var i=0;i<arr.length;i++){
            var id=arr[i].substring(0,arr[i].length-1);
            var v=arr[i].substr(arr[i].length-1,1);
            rate.render({
                elem: '#evaStar'+id,  //绑定元素
                theme: '#FF5722',
                readonly:true,
                value:v
            });
        }
    });

    <%--鼠标悬停，图片局部放大开始--%>
    var smallBox = document.getElementById('smallBox');
    var mask = document.getElementById('mask');
    var bigBox = document.getElementById('bigBox');
    var box = document.getElementById('box');
    var bigPic = document.getElementById('bigPic');
    //鼠标经过小盒子，显示大盒子
    smallBox.onmouseover = function () {
        bigBox.style.display = "block";
        mask.style.display = "block";

    };

    smallBox.onmouseout = function () {
        bigBox.style.display = "none";
        mask.style.display = "none";
    };
    smallBox.onmousemove = function (event) {
        //遮罩跟随鼠标
        var event = event || widow.event;
        var pageX = event.pageX || event.clientX + document.documentElement.scrollLeft;
        var pageY = event.pageY || event.clientY + document.documentElement.scrollTop;
        //计算mask的位置
        // var boxX = ;
        // var boxY = ;
        var targetX = pageX - box.offsetLeft - mask.offsetWidth / 2;
        var targetY = pageY - box.offsetLeft - mask.offsetHeight / 2;
        //限制mask移动范围
        if (targetX < 0) {
            targetX = 0;
        }
        // if(targetX > 175){
        // targetX = 175;
        // }
        if (targetY < 0) {
            targetY = 0;
        }
        // if(targetY > 175){
        // targetY = 175;
        // }

        if (targetX > smallBox.offsetWidth - mask.offsetWidth) {
            targetX = smallBox.offsetWidth - mask.offsetWidth;
        }

        if (targetY > smallBox.offsetHeight - mask.offsetHeight) {
            targetY = smallBox.offsetHeight - mask.offsetHeight;
        }
        //console.log(smallBox.offsetWidth-mask.offsetWidth);
        // console.log(mask.offsetWidth);
        //console.log(targetX);
        mask.style.left = targetX + "px";
        mask.style.top = targetY + "px";
        //按照比例移动大图
        var bigToMove = bigPic.offsetWidth - bigBox.offsetWidth;
        var maskToMove = smallBox.offsetWidth - mask.offsetWidth;
        var rate = bigToMove / maskToMove;
        bigPic.style.left = -rate * targetX + "px";
        bigPic.style.top = -rate * targetY + "px";
    };
    <%--鼠标悬停，图片局部放大结束--%>



    $(function () {
        //发送请求添加购物车
        $(".addCar").click(function () {
            var gid = $("#id").val();
            var num = $("#t_a").val();
            $.ajax({
                url: "${ctx}/cart/addCart",
                type: "get",
                data: {
                    "gid": gid,
                    "num": num
                },
                success: function (result) {
                    if (result.success === "sessionError") {
                        layer.msg(result.message);
                        setTimeout(function () {
                            window.location.href = "${ctx}/user/toLogin";
                        },500);
                    } else if (result.success === "true") {
                        layer.msg(result.message,{icon:1,offset:"t"});
                    } else if (result.success === "false") {
                        layer.msg(result.message,{icon:5,offset:"t"});
                    }
                }
            });
        });




        //发送请求添加收藏
        $(".mstBuy").click(function () {
            var gid = $("#id").val();
            $.ajax({
                url: "${ctx}/collect/addCollect",
                type: "get",
                data: {
                    "gid": gid,
                },
                success: function (result) {
                    if (result.success === "sessionError") {
                        layer.msg(result.message);
                        setTimeout(function () {
                            window.location.href = "${ctx}/user/toLogin";
                        },500);
                    }
                    else if (result.success === "collected") {
                        layer.msg(result.message,{icon:5,offset:"t"});
                    }
                    else if (result.success === "true") {
                        layer.msg(result.message,{icon:1,offset:"t"});
                    }
                    else if (result.success === "false") {
                        layer.msg(result.message,{icon:5,offset:"t"});
                    }
                }
            });
        });
    });
</script>
<%@include file="../../include/h_footer.jsp" %>
</body>
</html>