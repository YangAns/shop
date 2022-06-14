<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理-登陆</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/statics/layuimini/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="icon" href="${ctx}/statics/layuimini/images/favicon.ico">
<%--<!--[if lt IE 9]>--%>
    <%--<script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>--%>
    <%--<script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>--%>
    <%--<![endif]-->--%>
    <style>
        html, body {width: 100%;height: 100%;overflow: hidden}
        body {background: #1E9FFF;}
        body:after {content:'';background-repeat:no-repeat;background-size:cover;-webkit-filter:blur(3px);-moz-filter:blur(3px);-o-filter:blur(3px);-ms-filter:blur(3px);filter:blur(3px);position:absolute;top:0;left:0;right:0;bottom:0;z-index:-1;}
        .layui-container {width: 100%;height: 100%;overflow: hidden}
        .admin-login-background {width:360px;height:300px;position:absolute;left:50%;top:40%;margin-left:-180px;margin-top:-100px;}
        .logo-title {text-align:center;letter-spacing:2px;padding:14px 0;}
        .logo-title h1 {color:#1E9FFF;font-size:25px;font-weight:bold;}
        .login-form {background-color:#fff;border:1px solid #fff;border-radius:3px;padding:14px 20px;box-shadow:0 0 8px #eeeeee;}
        .login-form .layui-form-item {position:relative;}
        .login-form .layui-form-item label {position:absolute;left:1px;top:1px;width:38px;line-height:36px;text-align:center;color:#d2d2d2;}
        .login-form .layui-form-item input {padding-left:36px;}
        .captcha {width:60%;display:inline-block;}
        .captcha-img {display:inline-block;width:34%;float:right;}
        .captcha-img img {height:34px;border:1px solid #e6e6e6;height:36px;width:100%;}
    </style>
</head>
<body>
<div class="layui-container">
    <div class="admin-login-background">
        <div class="layui-form login-form">
            <form class="layui-form" action="">
                <div class="layui-form-item logo-title">
                    <h1>网上数码商城后台登录</h1>
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-username" for="loginName"></label>
                    <input type="text" id="loginName" name="loginName" lay-verify="required|account" placeholder="用户名" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-password" for="password"></label>
                    <input type="password" id="password" name="password" lay-verify="required|password" placeholder="密码" autocomplete="off" class="layui-input">
                </div>

                <%--滑块验证--%>
                <div class="layui-form-item">
                    <label class="layui-form-label" for="slider"></label>
                    <input type="text" id="slider" class="layui-input">
                </div>

                <div class="layui-form-item">
                    <button class="layui-btn layui-btn layui-btn-normal layui-btn-fluid" lay-submit="" lay-filter="login">登 入</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="${ctx}/statics/layuimini/lib/jquery-3.4.1/jquery-3.4.1.min.js" charset="utf-8"></script>
<script src="${ctx}/statics/layuimini/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="${ctx}/statics/layuimini/lib/jq-module/jquery.particleground.min.js" charset="utf-8"></script>
<script>
    layui.config({
        base: '${ctx}/statics/layuimini/lib/dist/sliderVerify/'
    }).use(['sliderVerify','form','layer','jquery'], function () {
        var form = layui.form,
            sliderVerify = layui.sliderVerify,
            layer = layui.layer;

        var slider = sliderVerify.render({
            elem: '#slider',
            isAutoVerify:false,//关闭自动验证
            bg : 'layui-bg-green',//自定义背景样式名
            // text : '滑动',
            onOk: function(){//当验证通过回调
                layer.msg("滑块验证通过",{icon:1});
            }
        });

        // 登录过期的时候，跳出ifram框架
        if (top.location !== self.location) top.location = self.location;

        // 粒子线条背景
        $(document).ready(function(){
            $('.layui-container').particleground({
                dotColor:'#7ec7fd',
                lineColor:'#7ec7fd'
            });
        });

        // 进行登录操作
        form.on('submit(login)', function (data) {
            if(slider.isOk()){//用于表单验证是否已经滑动成功
                // layer.msg(JSON.stringify(data.field));
                //发送ajax登录请求
                $.ajax({
                    url:"${ctx}/admin/adminuser/login",
                    type:"post",
                    data:data.field,
                    success:function (result) {
                        if(result.success){
                            window.location.href="${ctx}/admin/main.html"
                        }else{
                            layer.msg(result.message,{icon:5})
                        }
                    }
                });
            }else{
                layer.msg("请先通过滑块验证");
            }
            return false;
        });
    });
</script>
</body>
</html>