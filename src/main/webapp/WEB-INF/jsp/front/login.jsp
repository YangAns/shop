<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户登录</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/statics/front/user/css/style.css">
    <link rel="icon" href="${ctx}/statics/layuimini/images/favicon.ico">
    <script src="${ctx}/statics/front/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/statics/front/user/js/jquery.luara.0.0.1.min.js"></script>
    <script src="${ctx}/statics/front/layer/layer.js"></script>
</head>
<body>
<div class="width100 hidden_yh"
     style="height: 573px;background: url('${ctx}/statics/front/user/images/loginbj.jpg') no-repeat center">
    <div class="width1200 hidden_yh center_yh" style="margin-top: 75px">
        <div class="right_yh bj_fff" style="width:408px;height: 360px;">
            <form method="post">
                <h3 class="tcenter font30 c_33" style="font-weight: 100;margin-top: 36px;margin-bottom: 36px;">用户登录</h3>
                <div class="center_yh hidden_yh" style="width: 336px;">
                    <div class="width100 box-sizing hidden_yh"
                         style="height: 44px;border:1px solid #c9c9c9;margin-bottom: 34px;">
                        <img src="${ctx}/statics/front/user/images/rw.jpg" alt="" class="left_yh" width="42"
                             height="42">
                        <input type="text" placeholder="请输入用户名" id="userName"
                               style="border: 0;width: 292px;height: 42px; font-size: 16px;text-indent: 22px;">
                    </div>
                    <div class="width100 box-sizing hidden_yh"
                         style="height: 44px;border:1px solid #c9c9c9;margin-bottom: 10px;">
                        <img src="${ctx}/statics/front/user/images/pass.jpg" alt="" class="left_yh" width="42"
                             height="42">
                        <input type="password" placeholder="请输入密码" id="password"
                               style="border: 0;width: 292px;height: 42px; font-size: 16px;text-indent: 22px;">
                    </div>
                    <div>
                        <a style="font-size: 12px;color: #b1b1b1;float: right" href="javascript:void(0)" id="forget">忘记密码</a>
                    </div>
                    <input type="button" value="登录" class="center_yh" id="btn"
                           style="width: 100%;height: 43px;font-size: 16px;background: #dd4545;outline: none;border: 0;color: #fff; cursor:pointer;margin-top: 10px">
                </div>
                <div style="width: 408px;height:34px;margin-top: 5px;background-color: rgba(186,186,186,0.2);padding-top: 10px;">
                    <span style="font-size: 14px;margin-left: 245px;text-align: right;color: #9d9d9d">没有账号?</span><a
                        style="color: red;font-size: 14px;float: right;margin-right: 40px;" href="${ctx}/user/toReg">立即注册</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $("#btn").click(function () {
        var userName = $("#userName").val();
        var password = $("#password").val();
        if(userName.length===0){
            layer.msg("用户名不能为空",{icon:5,offset:"100px"})
            return false
        }else if(password.length===0){
            layer.msg("密码不能为空",{icon:5,offset:"100px"})
            return false
        }else{
            //提交表单
            $.post("${ctx}/user/exLogin", {"userName": userName, "password": password}, function (result) {
                if (result.success) {
                    layer.msg(result.message,{icon:1,offset:"t"})
                    location.href="${ctx}/index.html"
                }else{
                    layer.msg(result.message,{icon:5,offset:"t"})
                }
            }, "json");
        }

    });


    //打开忘记密码窗口
    $('#forget').click(function () {
        layer.open({
            type: 2, //类型 默认为0
            content: '${ctx}/user/forgetPwd', //内容
            area: ['500px', '600px'],
            offset: 't',  //坐标 默认垂直居中
            anim: 5 //弹出动画
            , move: false //触发拖动的元素  false禁止弹层拖动
        });
    });

</script>
<%@include file="../include/h_footer.jsp" %>
</body>
</html>



















