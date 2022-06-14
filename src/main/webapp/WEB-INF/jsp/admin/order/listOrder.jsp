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
    <div class="layuimini-main">
        <!-- 搜索条件 -->
        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">订单编号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="orderCode" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">订单状态</label>
                            <div class="layui-input-inline">
                                <select name="status" autocomplete="off" id="status" class="layui-input">
                                    <option value="">请选择</option>
                                    <option value="-1">已取消</option>
                                    <option value="0">待付款</option>
                                    <option value="1">待发货</option>
                                    <option value="2">待收货</option>
                                    <option value="3">待评价</option>
                                    <option value="4">已完成</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">开始日期</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="startDate" id="startTime" autocomplete="off"
                                           class="layui-input" readonly>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">结束日期</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="endDate" id="endTime" autocomplete="off"
                                           class="layui-input" readonly>
                                </div>
                            </div>
                            <div class="layui-inline" style="float: right">
                                <button type="submit" class="layui-btn" lay-submit lay-filter="data-search-btn"><i
                                        class="layui-icon layui-icon-search"></i>搜索
                                </button>
                                <button type="reset" class="layui-btn layui-btn-warm"><i
                                        class="layui-icon layui-icon-refresh-1"></i>重置
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <%-- 表格区域 --%>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <%-- 行工具栏区域 --%>
        <script type="text/html" id="currentTableBar">
            {{#  if(d.status==1){ }}
            <a class="layui-btn  layui-btn-warm layui-btn-xs" lay-event="deliver">发货</a>
            {{#  } }}
            <a class="layui-btn layui-btn-normal layui-btn-xs"  lay-event="show"><i
                    class="layui-icon layui-icon-form"></i>查看</a>
            <%--<a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit"><i--%>
            <%--        class="layui-icon layui-icon-edit"></i>编辑</a>--%>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete"><i
                    class="layui-icon layui-icon-delete"></i>删除</a>
        </script>
    </div>
</div>
<script src="${ctx}/statics/layuimini/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table', 'laydate'], function () {

        var $ = layui.$,
            form = layui.form,
            laydate = layui.laydate,
            table = layui.table;
        //渲染日期组件
        laydate.render({
            elem: '#startTime', //指定元素
            type: 'datetime'
        });
        laydate.render({
            elem: '#endTime', //指定元素
            type: 'datetime'
        });

        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${ctx}/order/list',
            toolbar: '#toolbarDemo',
            cols: [[
                {field: 'orderCode', width: 160, title: "订单编号", align: 'center'},
                {
                    field: 'user', width: 100, title: "下单用户", align: 'center', templet: function (d) {
                        return d.user.userName
                    }
                },
                {field: 'addTime', Width: 80, title: '下单时间', align: 'center'},
                {field: 'orderPrice', width: 100, title: "总金额", align: 'center'},
                {field: 'userAddress', width: 100, title: "收货地址", align: 'center',templet:function (d) {
                        return d.user.address
                    }},
                {field: 'statusStr', title: '订单状态', width: 100, align: 'center'},
                {title: '操作', Width: 500, toolbar: '#currentTableBar', align: "center"}
            ]],
            page: true,
        });
        // 监听行工具栏事件
        table.on("tool(currentTableFilter)", function (obj) {
            console.log(obj);
            switch (obj.event) {
                case "deliver":  //发货按钮
                    $.ajax({
                        url:"${ctx}/order/deliverOrder",
                        type:"post",
                        data:{
                            "id":obj.data.id
                        },
                        success:function (result) {
                            if(result.success){
                                layer.msg(result.message,{icon:6});
                                //刷新数据表格
                                tableIns.reload();
                            }else{
                                layer.msg(result.message,{icon:5})
                            }
                        }
                    });
                    break;
                case "show"://查看按钮
                    location.href="${ctx}/admin/toOrderDetail?orderId="+obj.data.id;
                    break;
                case "edit"://编辑按钮
                    // openUpdateWindow(obj.data);//打开修改窗口
                    break;
                case "delete"://删除按钮
                    deleteById(obj.data);
                    break;
            }
        });


        function deleteById(data) {
            console.log(data);
            layer.confirm("确定要删除吗",
                {icon: 3, title: '提示',offset:['100px','400px']}, function (index) {
                    //发送ajax请求进行删除
                    <%--alert('${sessionScope.loginUser.loginName}')--%>
                    if('${sessionScope.loginUser.loginName}'==="admin"){
                        $.post("${ctx}/order/deleteById", {"id": data.id}, function (result) {
                            if (result.success) {
                                layer.msg(result.message,{icon:1});
                                //刷新数据表格
                                tableIns.reload();
                            }else{
                                layer.msg(result.message,{icon:5});
                            }

                        }, "json");
                    }else {
                        layer.msg("你没有该权限！",{icon:5});
                    }
                    layer.close(index);
                });
        }

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            console.log(data);
            tableIns.reload({
                where: data.field,
                page: {
                    curr: 1
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
