<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/statics/front/css/app.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/statics/front/css/app2.css">
<script src="${pageContext.request.contextPath}/statics/front/jQuery-1.12.4.js"></script>
<script src="${pageContext.request.contextPath}/statics/front/layer/layer.js"></script>
<div class="dialog-wrapper">
    <div class="dialog">
        <div class="dialog-head">
            <button class="dialog-close"></button>
        </div>
        <div class="dialog-body">
            <div>
                <div class="form-wrap setnew-wrap">
                    <div class="form-wrap">
                        <div class="form-title">
                            邮箱验证
                        </div>
                        <div class="form-item clearfix form-item-xl">
                            <div class="item-rcol">
                                <div class="item-input-wrap">
                                    <input id="email" type="text" class="field" placeholder="请输入邮箱">
                                </div>
                                <div class="mix-btns ml10">
                                    <div>
                                        <div>
                                            <div>
                                                <button id="val" type="button" class="btn-def btn-msg btn-l "><i
                                                        class="icon iconfont icon-duanxin"></i>获取邮箱验证码
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="item-rcol" style="margin-top: 10px">
                                <div style=" width: 350px;height: 50px;border: 1px solid #ddd">
                                    <input id="emailCode" type="text" class="field" placeholder="验证码" maxlength="6">
                                </div>
                            </div>
                            <div class="item-rcol" style="margin-top: 10px">
                                <div style=" width: 350px;height: 50px;border: 1px solid #ddd">
                                    <input id="pwd" type="password" class="field" placeholder="新密码,建议大于6位">
                                </div>
                            </div>
                        </div>
                        <div class="form-item ac">
                            <button type="button" id="btforget" class="btn-primary btn-xl">提交</button>
                        </div>
                        <div class="wd-wrap">
                            <div class="wd-item">
                                <div class="wd-header">收不到邮箱验证码？</div>
                                <div class="wd-cont">请检查网络并且核实QQ是否屏蔽邮箱，如均正常请重新获取或稍后再试。</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    //获取邮箱验证码
    $("#val").click(function () {
        var email = $("#email").val();
        if (email !== "") {
            var index = layer.load(0, {shade: false});
            $.post("${pageContext.request.contextPath}/user/sendCode", {"email": email}, function (result) {
                if (result.exist) {
                    layer.msg(result.message, {icon: 6});
                } else {
                    layer.msg(result.message, {icon: 5})
                }
                layer.close(index)
            }, "json");
        } else {
            layer.msg("邮箱不能为空", {icon: 5})
        }

    });

    //找回密码
    $("#btforget").click(function () {
        var email = $("#email").val();
        var password = $("#pwd").val();
        var code = $("#emailCode").val();
        if (email.length === 0) {
            layer.msg("请填写邮箱", {icon: 5})
        } else if (code.length === 0) {
            layer.msg("请填写验证码", {icon: 5})
        } else if (password.length === 0) {
            layer.msg("请填写密码", {icon: 5})
        } else {
            $.post("${pageContext.request.contextPath}/user/updatePwdByEmail",
                {
                    "email": email,
                    "password": password,
                    "code": code
                }
                , function (result) {
                    if (result.success === "true") {
                        layer.msg(result.message, {icon: 6})
                    } else if (result.success === "codeError") {
                        layer.msg(result.message, {icon: 5})
                    } else if (result.success === "emailCodeError") {
                        layer.msg(result.message, {icon: 5})
                    } else {
                        layer.msg(result.message, {icon: 5})
                    }
                }, "json");
        }
    })

</script>
</body>
</html>
