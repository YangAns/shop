<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>修改密码</title>
    <link rel="stylesheet" href="${ctx}/statics/layuimini/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="icon" href="${ctx}/statics/layuimini/images/favicon.ico">
    <link type="text/css" rel="stylesheet" href="${ctx}/statics/front/user/css/style.css">
    <script src="${ctx}/statics/front/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/statics/front/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<style>
    img {
        display: inline-block;
    }
</style>
<body>
<%@include file="../include/h_top.jsp" %>
<!--导航条-->
<%@include file="../include/h_navigation.jsp" %>
<div class="width1200 center_yh hidden_yh font14" style="height: 40px;line-height: 40px;">
    <span>当前位置：</span><a href="${ctx}/index.html" class="c_66">首页</a>
    ><a href="#" class="c_66">个人中心</a>
    ><a href="#" class="c_66">修改密码</a>
</div>
<div class="width100 hidden_yh" style="background: #f0f0f0;padding-top: 34px;padding-bottom: 34px;">
    <div class="width1200 hidden_yh center_yh">
        <div id="vipNav">
            <a href="${ctx}/user/userCenter">个人信息</a>
            <a href="${ctx}/order/myOrder">我的订单</a>
            <a href="${ctx}/collect/myCollect">商品收藏</a>
            <a href="${ctx}/user/updatePwd" class="on">修改密码</a>
        </div>
        <div id="vipRight">
            <div class="font24"
                 style="height: 60px;line-height: 60px;text-indent: 50px;background: #f5f8fa;border-bottom: 1px solid #ddd;">
                修改密码
            </div>
            <div class="bj_fff hidden_yh" style="width: 838px;border:1px solid #ddd;margin-top: 30px;padding: 50px;">
                <div class="width100" style="height: 32px;line-height: 32px;">
                    <div class="left_yh font16 tright" style="width: 120px;">
                        <font class="red">*</font>旧密码：
                    </div>
                    <input type="password" id="oldpwd"
                           style="width: 243px;border: 1px solid #ddd;outline: none;height: 30px;text-indent: 10px;"/>
                    <span style="color: red"></span>
                </div>
                <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                    <div class="left_yh font16 tright" style="width: 120px;">
                        <font class="red">*</font>新密码：
                    </div>
                    <input type="password" id="newpwd"
                           style="width: 243px;border: 1px solid #ddd;outline: none;height: 30px;text-indent: 10px;"/>
                    <span style="color: red"></span>
                </div>
                <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                    <div class="left_yh font16 tright" style="width: 120px;">
                        <font class="red">*</font>确认新密码：
                    </div>
                    <input type="password" id="rpwd"
                           style="width: 243px;border: 1px solid #ddd;outline: none;height: 30px;text-indent: 10px;"/>
                    <span style="color: red"></span>
                </div>
                <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                    <a href="javascript:void(0)" class="left_yh block_yh font16 tcenter ff5802 con"
                       style="width: 244px;height: 33px;margin-left: 120px;">
                        提交
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${ctx}/statics/front/layer/layer.js"></script>
<script type="text/javascript">

    $(function () {
        var oldpwd = $("#oldpwd");
        var newpwd = $("#newpwd");
        var rpwd = $("#rpwd");
        var flag = true;

        oldpwd.focus(function () {
            oldpwd.next().html("* 请输入旧密码")
                .css("color", "#929292")
        });
        newpwd.focus(function () {
            newpwd.next().html("* 请输入新密码，密码长度必须是大于6小于20")
                .css("color", "#929292")
        });
        rpwd.focus(function () {
            rpwd.next().html("* 请输入与上面一致的密码")
                .css("color", "#929292")
        });


        newpwd.blur(function () {
            if (newpwd.val().trim().length > 0) {
                if (newpwd.val().length > 6 && newpwd.val().length < 20 && oldpwd.val() !== newpwd.val()) {
                    newpwd.next().html("<img width='15px' src='${ctx}/statics/front/images/y.png'/>")
                        .css("color", "#47920c");
                    flag = true
                } else if (newpwd.val() !== "" && oldpwd.val() === newpwd.val()) {
                    newpwd.next().html("新密码与旧密码重复")
                        .css("color", "#ff0d00");
                    flag = false
                } else {
                    newpwd.next().html("密码长度必须是大于6小于20")
                        .css("color", "#ff0d00");
                    flag = false
                }
            }
        });
        rpwd.blur(function () {
            if (rpwd.val().trim().length > 0) {
                if (rpwd.val() !== "" && rpwd.val() === newpwd.val()) {
                    rpwd.next().html("<img width='15px' src='${ctx}/statics/front/images/y.png'/>")
                        .css("color", "#47920c");

                } else {
                    rpwd.next().html("两次密码输入不一致，请重新输入")
                        .css("color", "#ff0d00");
                    flag = false
                }
            }
        });


        //发送ajax请求验证旧密码
        oldpwd.blur(function () {
            if (oldpwd.val() !== '${sessionScope.user.password}') {
                oldpwd.next().html("原密码输入不正确")
                    .css("color", "#ff0d00")
            }
            $.ajax({
                url: "${ctx}/user/vanOldPwd",
                type: "get",
                data: {
                    "oldpwd": oldpwd.val()
                },
                success: function (result) {
                    if (result.message === "true") {
                        oldpwd.next().html("<img width='15px' src='${ctx}/statics/front/images/y.png'/>")
                            .css("color", "#47920c")
                    } else if (result.message === "false") {
                        oldpwd.next().html("原密码输入不正确")
                            .css("color", "#ff0d00")
                    } else if (result.message === "sessionError") {
                        oldpwd.next().html("当前session过期请重新登录")
                            .css("color", "#ff0d00")
                    } else if (result.message === "error") {
                        oldpwd.next().html("请输入旧密码")
                            .css("color", "#ff0d00")
                    }
                }
            })
        });

        $('.con').click(function () {
            // alert(111);
            var jiu = oldpwd.val();
            var xin = newpwd.val();
            var que = rpwd.val();
            if (jiu == null || jiu === '') {
                layer.msg("旧密码不能为空");
                return false;
            }
            if (xin == null || xin === '') {
                layer.msg("新密码不能为空");
                return false;
            }
            if (que == null || que === '') {
                layer.msg("确认密码不能为空");
                return false;
            }
            console.log(flag);
            if (oldpwd.val() == '${sessionScope.user.password}' && flag) {
                $.ajax({
                    type: "POST",
                    url: "${ctx}/user/exUpdatePwd",
                    data: {
                        "password": xin
                    },
                    success: function (result) {
                        if (result.success) {
                            layer.msg(result.message, {offset: "t",icon:6});
                            setTimeout(function () {
                                location.href = "${ctx}/user/toLogin";
                            }, 1000);

                        } else {
                            layer.msg(result.message,{offset: "t",icon:5})
                        }
                    }
                })
            } else {
                oldpwd.blur();
                newpwd.blur();
                rpwd.blur();
            }
        })
    });


</script>
<%@include file="../include/h_footer.jsp" %>
</body>
</html>



















