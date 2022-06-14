<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>购物车</title>
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
    ><a href="#" class="c_66">我的购物车</a>
</div>
<c:if test="${!empty cartList}">
    <div class="width1200 hidden_yh center_yh font20">
        全部商品<font class="red">(${fn:length(cartList)})</font>
    </div>
    <div class="width1198 hidden_yh center_yh" style="border: 1px solid #ddd;margin-top: 18px;min-height: 300px;">
        <div class="width100 hidden_yh fQont14" style="height: 32px;line-height: 32px;background: #f0f0f0;text-indent: 21px;
    color: #000;font-weight: 600;border-bottom: 1px solid #ddd;">商品详情
        </div>
        <div class="width100 hidden_yh font14" style="height: 42px;line-height: 42px;border-bottom: 1px solid #ddd;">
            <div class="left_yh tcenter font14" style="width: 486px;">商品信息</div>
            <div class="left_yh tcenter font14" style="width: 175px;">单价</div>
            <div class="left_yh tcenter font14" style="width: 175px;">数量</div>
            <div class="left_yh tcenter font14" style="width: 175px;">金额</div>
            <div class="left_yh tcenter font14" style="width: 175px;">操作</div>
        </div>
        <c:forEach var="data" items="${cartList}" varStatus="l">
            <div class="speCific" data-id="${data.id}">
                <div class="xzWxz">
                    <b><img src="${ctx}/statics/front/user/images/xzwxz.png" alt=""></b>
                </div>

                <a href="${ctx}/goodsDetail/${data.goods.id}">
                    <div class="xzSp">
                        <img src="/shop/upload/${data.goods.pic}" alt="">
                        <div class="xzSpIn" style="">
                            <h3 class="font16 c_33 font100" style="margin-bottom: 10px">${data.goods.name}</h3>
                        </div>
                    </div>
                </a>

                <div class="xzJg">
                    ￥<font>${data.price}</font>
                </div>
                <div class="xzSl">
                    <div class="xzSlIn">
                        <b class="Amin">-</b>
                        <input type="text" value="${data.num}" readonly class="cOnt"/>
                        <b style="border-right: none;border-left: #ddd;" class="Aadd">+</b>
                    </div>
                </div>
                <div class="xzXj">
                    ￥<font></font>
                </div>
                <div class="xzCz">
                    <div class="xzCzIn">
                        <a href="javascript:void(0)" class="Dels" data-id="${data.id}">删除</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="width1198 center_yh" style="height: 60px;background: #f0f0f0;border: 1px solid #ddd;margin-top: 40px">
        <div class="center_yh hidden_yh" style="width: 1178px;height: 60px;margin-left: 20px;">
            <div class="ifAll"><b><img src="${ctx}/statics/front/user/images/xzwxz.png" alt=""></b><font>全选</font></div>
            <div class="ifDel">删除</div>
            <div class="sXd">
                <div class="sXd1">已选商品（<font style="color: #cb1c20">0</font>）</div>
                <div class="sXd2">合计（不含运费）：￥<font style="color: #cb1c20" id="zjJg">0</font></div>
                <a href="javascript:void(0)" class="ifJs" onclick="ifJs()">结算</a>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${empty cartList}">
    <div style="text-align: center;color: #828282">您的购物车还是空的，赶紧行动吧！</div>
</c:if>
<script src="${ctx}/statics/front/layer/layer.js"></script>
<script type="text/javascript">
    //总的子项数
    var es = $(".speCific").length;
    //给小计赋值
    (function cx() {
        for (let a = 0; a < es; a++) {
            var lt = $('.xzJg').eq(a).find("font").html();
            var num = $('.xzSl').eq(a).find("input").val();
            var xj = lt * num;
            $('.xzXj').eq(a).find("font").html(xj);
        }
    })();
    // 选择或不选择一项
    $('.xzWxz').click(function () {
        if ($(this).hasClass("on")) {
            $(this).removeClass("on");

        } else {
            $(this).addClass("on");
        }
        var ty = $(".xzWxz.on").length;
        $(".sXd1").find("font").html(ty);
        if (ty === es) {
            $('.ifAll').addClass("on");
        } else {
            $('.ifAll').removeClass("on");
        }
        jsZj();
    });

    //计算总计
    function jsZj() {
        var total = 0;
        $(".xzWxz.on").each(function () {
            var price = $(this).parent().find(".xzJg").find("font").html();
            var num = $(this).parent().find(".xzSl").find("input").val();
            total += price * num;
        });
        $('#zjJg').html(total.toFixed(2))
    }

    $('.Aadd').click(function () {
        var t = $(this).siblings(".cOnt").val() * 1;
        var price = $(this).parent().parent().siblings(".xzJg").find("font").html() * 1;
        t++;
        $(this).siblings(".cOnt").val(t);
        $(this).parent().parent().siblings(".xzXj").find("font").html((price * t).toFixed(2));
        jsZj();
    });

    $('.Amin').click(function () {
        var t = $(this).siblings(".cOnt").val() * 1; //获取到数量值
        var price = $(this).parent().parent().siblings(".xzJg").find("font").html() * 1; //获取到价格
        t--;
        if (t < 1) {
            t = 1
        }
        $(this).siblings(".cOnt").val(t);
        $(this).parent().parent().siblings(".xzXj").find("font").html((price * t).toFixed(2));
        jsZj();
    });

    $('.ifAll').click(function () {
        if ($('.ifAll').hasClass("on")) {
            $(this).removeClass("on");
            $('.xzWxz').removeClass("on");
            $('.sXd1').find("font").html(0);
        } else {
            $(this).addClass("on");
            $('.xzWxz').addClass("on");
            $('.sXd1').find("font").html(es);
        }
        jsZj();
    });

    //单项删除
    $(".Dels").click(function () {
        var id = $(this).attr("data-id");
        layer.confirm('确定要删除该宝贝吗？', {title: '删除宝贝', offset: "100px"}, function (index) {
            $.ajax({
                url: "${ctx}/cart/deleteById",
                type: "get",
                data: {
                    "id": id
                },
                success: function (result) {
                    if (result.success) {
                        layer.msg(result.message);
                        location.reload();
                    } else {
                        layer.msg(result.message)
                    }
                }
            });
            $(this).parent().parent().parent().remove();
            jsZj();
            layer.close(index);
        });
    });

    //批量删除
    $(".ifDel").click(function () {
        if ($('.xzWxz').hasClass("on")) {
            layer.confirm('确定要删除这些宝贝吗？', {title: '删除宝贝', offset: "100px"}, function (index) {
                $(".xzWxz.on").each(function () {
                    var id = $(this).parent().attr("data-id");
                    $.ajax({
                        url: "${ctx}/cart/deleteById",
                        type: "get",
                        data: {
                            "id": id
                        },
                        success: function (result) {
                            if (result.success) {
                                layer.msg(result.message);
                                $(".xzWxz.on").parent().remove();
                                location.reload();
                            }
                            // layer.msg(result.message)
                        }
                    });
                });
                jsZj();
                layer.close(index);
            });
        } else {
            layer.msg("请选择宝贝",{offset: "100px",icon:5})
        }
    });

    /**
     * 结算 --- 进入购买流程
     */
    function ifJs() {
        var arr = [];
        $(".xzWxz.on").each(function () {
            var $id = $(this).parent().attr("data-id");
            var $num = $(this).parent().find(".xzSl").find("input").val();
            var obj = {};
            obj.id = $id;
            obj.num = $num;
            arr.push(obj);
        });
        if (arr.length === 0) {
            layer.msg("请至少选择一个商品结算", {offset: "t", icon: 5});
            return false
        }
        console.log(JSON.stringify(arr));
        $.ajax({
            type: "POST",
            url: "${ctx}/order/saveOrder",
            data: JSON.stringify(arr),
            async: false,
            contentType: "application/json",
            success: function (result) {
                if (result.message === "SessionError") {
                    layer.msg("请先登录", {offset: "t", icon: 5});
                    window.location.href = "${ctx}/user/toLogin";
                } else if (result.message === "addressNull") {
                    layer.msg("请先填写地址和真实姓名", {offset: "t", icon: 5});
                    setTimeout(function () {
                        location.href = "${ctx}/user/userCenter"
                    }, 1000);
                } else if (result.message === "true") {
                    location.href = "${ctx}/order/submitOrder/"+result.orderId
                }
            }
        })
    }
</script>
<%@include file="../../include/h_footer.jsp" %>
</body>
</html>



















