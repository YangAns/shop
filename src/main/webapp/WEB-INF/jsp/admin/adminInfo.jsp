<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>基本资料</title>
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
        <div class="layui-form layuimini-form" lay-filter="dataFrm">
            <div class="layui-form-item">
                <label class="layui-form-label required">管理账号</label>
                <div class="layui-input-block">
                    <%--编号隐藏域--%>
                    <input type="hidden" name="id">
                    <input type="text" name="loginName" lay-verify="required" lay-reqtext="管理账号不能为空" placeholder="请输入管理账号"  value="admin" class="layui-input" readonly>
                    <tip>填写自己管理账号的名称。</tip>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label required">姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="realName" lay-verify="required" lay-reqtext="姓名不能为空" placeholder="请输入姓名"  value="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label required">手机</label>
                <div class="layui-input-block">
                    <input type="text" name="phone" lay-verify="required" lay-reqtext="手机不能为空" placeholder="请输入手机"  value="" class="layui-input">
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


        $.post("${ctx}/admin/adminuser/findAdminById",function (result) {
            console.log(result);
            form.val("dataFrm",result)
        },"json");
        //监听提交
        form.on('submit(saveBtn)', function (data) {
            console.log(data);
            $.post("${ctx}/admin/adminuser/updateAdmin",data.field,function (result) {
                if (result.success) {
                    layer.msg(result.message,{icon:1});
                }else{
                    layer.msg(result.message,{icon:5});
                }
            },"json");
            return false;
        });

    });
</script>
</body>
</html>