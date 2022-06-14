<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户注册</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/statics/front/user/css/style.css">
    <link rel="icon" href="${ctx}/statics/layuimini/images/favicon.ico">
    <script src="${ctx}/statics/front/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/statics/front/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<body>
<div class="width100 hidden_yh" style="border-top: 1px solid #ddd;background: url('${ctx}/statics/front/user/images/zcbg.webp') no-repeat center">
    <div class="width1200 hidden_yh center_yh" style="margin-top: 50px">
        <form id="userForm" method="post">
            <h3 class="tcenter font30 c_33" style="font-weight: 100;margin-bottom: 20px">用户注册</h3>
            <div class="center_yh hidden_yh" style="width: 475px;margin-bottom: 40px;">
                <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;"
                      class="left_yh block_yh tright">用户名：</span>
                <input type="text" name="userName" placeholder="请输入您的用户名"
                       style="border:1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px;"
                       class="left_yh">
                <span style="margin-left: 150px;font-size: 14px"></span>
            </div>
            <div class="center_yh hidden_yh" style="width: 475px;margin-bottom: 40px;">
                <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;"
                      class="left_yh block_yh tright">设置密码：</span>
                <input type="password" name="password" placeholder="建议至少使用两种字符组合"
                       style="border:1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px;"
                       class="left_yh">
                <span style="margin-left: 150px;font-size: 14px"></span>
            </div>
            <div class="center_yh hidden_yh" style="width: 475px;margin-bottom: 40px;">
                <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;"
                      class="left_yh block_yh tright">手机号：</span>
                <input type="text" name="phone" placeholder="建议使用常用的手机"
                       style="border:1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px;"
                       class="left_yh">
                <span style="margin-left: 150px;font-size: 14px"></span>
            </div>
            <div class="center_yh hidden_yh" style="width: 475px;margin-bottom: 40px;">
                <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;"
                      class="left_yh block_yh tright">电子邮箱：</span>
                <input type="text" name="email" placeholder="请输入邮箱"
                       style="border:1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px;"
                       class="left_yh">
                <span style="margin-left: 150px;font-size: 14px"></span>
            </div>

            <div class="center_yh hidden_yh" style="width: 475px;margin-bottom: 20px;">
                <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;"
                      class="left_yh block_yh tright">验证码：</span>
                <input type="text" name="code" placeholder="请输入邮箱验证码"
                       style="border:1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px;"
                       class="left_yh">
                <span style="margin-left: 150px;font-size: 14px"></span>
            </div>
            <input type="button" value="获取邮箱验证码" id="val" style="width: 295px;height: 44px;margin-left: 500px;border: none">
            <p class="font14 c_66" style="text-indent: 500px;margin-top: 30px;">
                <input id="xieyi" type="checkbox" >我已阅读并同意<a href="#" class="red">《会员注册协议》</a>和<a href="#" class="red">《隐私保护政策》</a>
            </p>
            <input type="button" value="提交" class="ipt_tj" style="width: 295px;height: 44px;margin-left: 500px;">
        </form>
    </div>
</div>
<script src="${ctx}/statics/front/jQuery-1.12.4.js"></script>
<script src="${ctx}/statics/front/layer/layer.js"></script>
<script>

    $(function () {
        var userName = $("input[name='userName']");
        var password = $("input[name='password']");
        var phone = $("input[name='phone']");
        var email = $("input[name='email']");
        var code = $("input[name='code']");
        var xieyi = $("#xieyi");
        var btnSubmit = $(".ipt_tj");
        var flagUserName = true;
        var flagEmail = true;
        userName.focus(function () {
            userName.next().html("支持英文、数字、__ 的组合，4-16个字符")
                .css("color", "#929292")
        });
        password.focus(function () {
            password.next().html("密码长度大于6小于20")
                .css("color", "#929292")
        });
        phone.focus(function () {
            phone.next().html("请输入手机号码")
                .css("color", "#929292")
        });
        email.focus(function () {
            email.next().html("请输入邮箱,例如:xxx@qq.com")
                .css("color", "#929292")
        });

        userName.blur(function () {
            if (userName.val().trim().length > 0) {
                $.get("${ctx}/user/checkName", {"userName": userName.val().trim()}, function (result) {
                    if (result.exist) {
                        layer.msg(result.message, {icon: 5, offset: "t"});
                        //修改状态为false，表示已存在
                        flagUserName = false;
                    } else {
                        flagUserName = true;//不存在
                    }
                }, "json");


                var reg = /^[a-zA-Z0-9_]{4,16}$/;
                if (reg.test(userName.val())) {
                    userName.next().html("");
                    userName.attr("status", true);
                } else {
                    userName.next().html("用户名不符合规范，请重新输入")
                        .css("color", "#ff0d00");
                    userName.attr("status", false);
                }
            }
        });
        password.blur(function () {
            if (password.val().trim().length > 0) {
                if (password.val() != null && password.val().length > 6 && password.val().length < 20) {
                    password.next().html("");
                    password.attr("status", true);
                } else {
                    password.next().html("密码输入不符合规范，请重新输入")
                        .css("color", "#ff0d00");
                    password.attr("status", false);

                }
            }
        });

        phone.blur(function () {
            if (phone.val().trim().length > 0) {
                var reg = /^1([3456789])\d{9}$/;
                if (reg.test(phone.val())) {
                    phone.next().html("");
                    phone.attr("status", true);
                } else {
                    phone.next().html("手机号不符合规范，请重新输入")
                        .css("color", "#ff0d00");
                    password.attr("status", false);
                }
            }
        });

        email.blur(function () {
            if (email.val().trim().length > 0) {
                $.get("${ctx}/user/checkEmail", {"email": email.val().trim()}, function (result) {
                    if (result.exist) {
                        layer.msg(result.message, {icon: 5, offset: "t"});
                        //修改状态为false，表示已存在
                        flagEmail = false;
                    } else {
                        flagEmail = true;//不存在
                    }
                }, "json");

                var reg = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
                if (reg.test(email.val())) {
                    email.next().html("");
                    email.attr("status", true);
                } else {
                    email.next().html("邮箱输入不符合规范，请重新输入")
                        .css("color", "#ff0d00");
                    email.attr("status", false);
                }
            }


        });
        btnSubmit.click(function () {
            if (userName.val().trim().length === 0) {
                layer.msg("用户名不能为空");
                return false;
            }
            if (password.val().trim().length === 0) {
                layer.msg("密码不能为空");
                return false;
            }
            if (phone.val().trim().length === 0) {
                layer.msg("手机号不能为空");
                return false;
            }
            if (email.val().trim().length === 0) {
                layer.msg("邮箱不能为空");
                return false;
            }
            if (code.val().trim().length === 0) {
                layer.msg("验证码不能为空");
                return false;
            }
            if (xieyi.is(":checked")===false) {
                layer.msg("请勾选会员注册协议");
                return false;
            }

            if (flagEmail && flagUserName && userName.attr("status") === "true" &&
                password.attr("status") === "true" &&
                phone.attr("status") === "true" &&
                email.attr("status") === "true"
            ) {
                $.post("${pageContext.request.contextPath}/user/exReg",$('#userForm').serialize(),function (result) {
                    if(result.message==="emailCodeError"){
                        layer.msg("请先获取验证码", {icon: 5, offset: "t"})
                    }else if(result.message==="codeError"){
                        layer.msg("验证码错误", {icon: 5, offset: "t"})
                    }else{
                        layer.msg("注册成功，请登录", {icon: 1, offset: "t"})
                        window.location.href="${pageContext.request.contextPath}/user/toLogin"
                    }
                 },"json")

            } else if (flagUserName === false) {
                layer.msg("用户名已被使用，请重新输入！", {icon: 5, offset: "t"})
            } else if (flagEmail === false) {
                layer.msg("邮箱已被使用，请重新输入！", {icon: 5, offset: "t"})
            } else {
                userName.blur();
                password.blur();
                phone.blur();
                email.blur();
            }
        });
        //获取邮箱验证码
        $("#val").click(function () {
            if(email.val()!=="") {
                var index = layer.load(0, {shade: false});
                $.post("${pageContext.request.contextPath}/user/regSendCode", {"email": email.val()}, function (result) {
                    layer.msg(result.message,{icon:1,offset: "t"});
                    layer.close(index)
                }, "json");
            }else{
                layer.msg("邮箱不能为空")
            }
        });
    })
</script>
<%@include file="../include/h_footer.jsp" %>
</body>
</html>



















