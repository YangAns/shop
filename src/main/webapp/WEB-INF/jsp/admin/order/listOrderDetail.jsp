<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${ctx}/statics/layuimini/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${ctx}/statics/layuimini/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main" id="orderDetail" style="display: none">
        <%-- 表格区域 --%>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
    </div>
</div>
<script src="${ctx}/statics/layuimini/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table', 'laydate', 'layer'], function () {
        var $ = layui.$,
            form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            table = layui.table;

        //页面一打开就执行弹层
        layer.ready(function () {
            layer.open({
                type: 1,//打开类型
                area: ["800px", "800px"],//窗口宽高
                content: $("#orderDetail"),//引用的内容窗口
                offset: 't',
                cancel: function (index, layero) {
                    location.href = "${ctx}/admin/toOrderManager"
                }
            });
        });

        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${ctx}/orderDetail/list?orderId=' +${orderId},
            toolbar: '#toolbarDemo',
            cols: [[
                {field: 'id', width: 160, title: "编号", align: 'center'},
                {
                    field: 'goodsName', width: 160, title: "商品名称", align: 'center', templet: function (d) {
                        return d.goods.name
                    }
                },
                {field: 'goodsPic', Width: 80, title: '商品图片', align: 'center',templet:function (d) {
                        return '<img  src="/shop/upload/' + d.goods.pic + '"  width="50px" height="50px" onclick="showBigImage(this)">'
                    }},
                {
                    field: 'goodsPrice', width: 100, title: "单价", align: 'center', templet: function (d) {
                        return d.goods.price
                    }
                },
                {field: 'detailNum', title: '购买数量', width: 100, align: 'center'},
                {field: 'detailPrice', title: '小计', width: 100, align: 'center'},
            ]],
            page: true,
        });
    });
</script>
</body>
</html>
