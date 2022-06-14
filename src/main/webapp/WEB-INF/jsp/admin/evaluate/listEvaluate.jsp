<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <%-- 搜索条件 --%>
        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">评价人</label>
                            <div class="layui-input-inline">
                                <input type="text" name="uid" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn" lay-submit lay-filter="data-search-btn"><i
                                    class="layui-icon layui-icon-search"></i>搜索
                            </button>
                            <button type="reset" class="layui-btn layui-btn-warm"><i
                                    class="layui-icon layui-icon-refresh-1"></i>重置
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>


        <%-- 数据表格 --%>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <%-- 行工具栏 --%>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete"><i
                    class="layui-icon layui-icon-close"></i>删除</a>
        </script>
    </div>
</div>
<script src="${ctx}/statics/layuimini/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table', 'laydate', 'jquery', 'layer', 'upload', 'layedit'], function () {
        var $ = layui.jquery,
            form = layui.form,
            laydate = layui.laydate,
            upload = layui.upload,
            layedit = layui.layedit,
            layer = layui.layer,
            table = layui.table;

        //渲染表格组件
        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${ctx}/evaluate/list',
            toolbar: '#toolbarDemo',
            cols: [[
                {field: 'id', width: 120, title: '编号', align: 'center'},
                {field: 'evaUser', minWidth: 120, title: '评价人', align: 'center',templet:function (d) {
                    return d.user.userName
                    }},
                {field: 'content', minWidth: 120, title: '评价内容', align: 'center'},
                {field: 'addTime', minWidth: 120, title: '评价时间', align: 'center'},
                {field: 'evaGoods', minWidth: 120, title: '评价商品', align: 'center',templet:function (d) {
                    return d.goods.name
                    }},
                {field: 'grade', minWidth: 120, title: '评价星级', align: 'center'},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            page: true,
            done: function (res, curr, count) {
                //判断当前页码是否是大于1并且当前页的数据量为0
                if (curr > 1 && res.data.length == 0) {
                    var pageValue = curr - 1;
                    //刷新数据表格的数据
                    tableIns.reload({
                        page: {curr: pageValue}
                    });
                }
            }
        });

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


        //监听行工具栏事件
        table.on("tool(currentTableFilter)", function (obj) {
            console.log(obj);
            if (obj.event === "delete") {
                deleteById(obj.data);
            }
        });
        function deleteById(data) {
            console.log(data);
            //提示用户是否删除
            layer.confirm("确定要删除吗",
                {icon: 3, title: '提示',offset:['100px','400px']}, function (index) {
                    //发送ajax请求进行删除
                    $.post("${ctx}/evaluate/deleteById", {"id": data.id}, function (result) {
                        if (result.success) {
                            layer.msg(result.message,{icon:1});
                            //刷新数据表格
                            tableIns.reload();
                        }else{
                            //提示
                            layer.msg(result.message,{icon:5});
                        }

                    }, "json");
                    layer.close(index);
                });
        }

    });
</script>
</body>
</html>
