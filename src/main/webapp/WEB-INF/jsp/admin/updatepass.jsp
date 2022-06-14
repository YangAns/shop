<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${ctx}/statics/layuimini/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${ctx}/statics/layuimini/css/public.css" media="all">
    <style>
        .layui-form-item .layui-input-company {width: auto;padding-right: 10px;line-height: 38px;}
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="layui-form layuimini-form">
            <div class="layui-form-item">
                <label class="layui-form-label required">旧的密码</label>
                <div class="layui-input-block">
                    <input type="password" name="old_password" lay-verify="required" lay-reqtext="旧的密码不能为空" placeholder="请输入旧的密码"  value="" class="layui-input">
                    <tip>填写自己账号的旧的密码。</tip>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label required">新密码</label>
                <div class="layui-input-block">
                    <input type="password" name="new_password" lay-verify="required" lay-reqtext="新的密码不能为空" placeholder="请输入新的密码"  value="" class="layui-input">
                    <tip>密码长度必须是大于6小于20。</tip>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label required">确认新密码</label>
                <div class="layui-input-block">
                    <input type="password" name="again_password" lay-verify="required" lay-reqtext="新的密码不能为空" placeholder="确认新密码"  value="" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${ctx}/statics/layuimini/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="${ctx}/statics/layuimini/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['form','miniTab',"jquery"], function () {
        var form = layui.form,
            $ = layui.jquery,
            layer = layui.layer,
            miniTab = layui.miniTab;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            console.log(data);
            console.log(data.field.new_password.length);
            if(data.field.old_password!=${sessionScope.loginUser.password}){
                layer.msg("旧密码不正确",{icon:5})
            }else if(data.field.old_password===data.field.new_password){
                layer.msg("新密码与旧密码重复",{icon:5})
            }else if(data.field.new_password!==data.field.again_password){
                layer.msg("两次密码输入不一致！请重新输入",{icon:5})
            }else if((data.field.new_password.length<6)||(data.field.new_password.length>20)){
                layer.msg("新密码长度必须是大于6小于20",{icon:5})
            }else{
                $.post("${ctx}/admin/adminuser/updateAdminPwd",{"newPwd":data.field.new_password},function (result) {
                    if (result.success) {
                        layer.msg(result.message,{icon:1});
                        setTimeout(function () {
                            location.href="${ctx}/admin/adminuser/loginout"
                        },1000);
                    }else{
                        layer.msg(result.message,{icon:5});
                    }
                },"json");
            }
            return false;
        });

    });
</script>
</body>
</html>
