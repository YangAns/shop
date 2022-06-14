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

        <%-- 搜索条件区域 --%>
        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">用户名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="userName" autocomplete="off" class="layui-input">
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

        <%-- 表格区域 --%>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit"><i
                    class="layui-icon layui-icon-edit"></i>编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete"><i
                    class="layui-icon layui-icon-delete"></i>删除</a>
        </script>

        <%-- 添加和修改窗口 --%>
        <div style="display: none;padding: 5px" id="addOrUpdateWindow">
            <form class="layui-form" style="width:90%;" id="dataFrm" lay-filter="dataFrm">

                <div class="layui-form-item">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-block">
                        <%-- 隐藏域 --%>
                        <input type="hidden" name="id">
                        <input type="text" name="userName" lay-verify="required" autocomplete="off"
                               placeholder="请输入用户名称" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">手机号</label>
                    <div class="layui-input-block">
                        <input type="text" name="phone" lay-verify="required" autocomplete="off"
                               placeholder="请输入手机号" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">邮箱</label>
                    <div class="layui-input-block">
                        <input type="text" name="email" lay-verify="required" autocomplete="off"
                               placeholder="请输入邮箱" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">地址</label>
                    <div class="layui-input-block">
                        <input type="text" name="address" lay-verify="required" autocomplete="off"
                               placeholder="请输入地址" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item layui-row layui-col-xs12">
                    <div class="layui-input-block" style="text-align: center;">
                        <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit">
                            <span class="layui-icon layui-icon-add-1"></span>提交
                        </button>
                        <button type="reset" class="layui-btn layui-btn-warm">
                            <span class="layui-icon layui-icon-refresh-1"></span>重置
                        </button>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>
<script src="${ctx}/statics/layuimini/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {

        var $ = layui.$,
            form = layui.form,
            table = layui.table;

        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${ctx}/user/list',
            toolbar: '#toolbarDemo',
            cols: [[
                {field: 'id', width: 80, title: "编号", align: 'center'},
                {
                    field: 'pic', width: 100, title: "用户头像", align: 'center', templet: function (d) {
                        if (d.pic != null) {
                            return '<img  src="/shop/upload/' + d.pic + '" width="50px"   onclick="showBigImage(this)">'
                        } else {
                            return ""
                        }
                    }
                },
                {field: 'userName', width: 100, title: "用户名", align: 'center'},
                {field: 'phone', Width: 120, title: '手机号', align: 'center'},
                {field: 'realName', width: 100, title: "真实姓名", align: 'center'},
                {field: 'sex', width: 80, title: '性别', align: 'center'},
                {field: 'email', width: 130, title: "邮箱", align: 'center'},
                {field: 'address', Width: 120, title: '地址', align: 'center'},
                {
                    field: 'status', Width: 120, title: '用户状态', align: 'center', templet: function (d) {
                        if (d.status === 1) {
                            return "<input type='checkbox' lay-filter='switchTest' name='" + d.id + "' lay-skin='switch' lay-text='禁用|正常'>";
                        } else {
                            return "<input type='checkbox' lay-filter='switchTest' name='" + d.id + "' lay-skin='switch' lay-text='禁用|正常' checked>";
                        }
                    }
                },
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            page: true,
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
            if (obj.event === "edit") {
                openUpdateWindow(obj.data);
            } else if (obj.event === "delete") {
                deleteById(obj.data);
            }
        });


        var url;//提交地址
        var mainIndex;//打开窗口的索引

        /**
         * 打开修改窗口
         * @param data 当前行的数据
         */
        function openUpdateWindow(data) {
            mainIndex = layer.open({
                type: 1,//打开类型
                title: "编辑用户信息",//窗口标题
                area: ["600px", "400px"],//窗口宽高
                content: $("#addOrUpdateWindow"),//引用的内容窗口
                success: function () {
                    //表单数据回显menu
                    form.val("dataFrm", data);//参数1：lay-filter值 参数2：回显的数据
                    //修改的提交请求
                    url = "${ctx}/user/adminUpdateUser";
                }
            });
        }

        //删除用户
        function deleteById(data) {
            layer.confirm("确定要删除[<font color='red'>" + data.userName + "</font>]吗",
                {icon: 3, title: '提示'}, function (index) {
                    //发送ajax请求进行删除
                    $.post("${ctx}/user/deleteById", {"id": data.id}, function (result) {
                        if (result.success) {
                            layer.msg(result.message, {icon: 1});
                            //刷新数据表格
                            tableIns.reload();
                        }else{
                            //提示
                            layer.msg(result.message, {icon: 5});
                        }
                    }, "json");
                    layer.close(index);

                });
        }

        //监听表单提交事件
        form.on("submit(doSubmit)", function (data) {
            console.log(data);
            $.ajax({
                url: url,
                type: "post",
                data: data.field,
                success: function (result) {
                    if (result.success) {
                        layer.msg(result.message, {icon: 1});
                        //刷新数据表格
                        tableIns.reload();
                        //关闭窗口
                        layer.close(mainIndex);
                    } else {
                        //提示信息
                        layer.msg(result.message, {icon: 5});
                    }

                }
            });
            //禁止页面刷新
            return false;
        });


        window.showBigImage = function (e) {
            layer.open({
                type: 1,
                title: false,
                closeBtn: 0,
                shadeClose: true, //点击阴影关闭
                area: [$(e).width + 'px', $(e).height + 'px'], //宽高
                content: "<img src=" + $(e).attr('src') + "  width='100px' height='100px'/>"
            });
        }

        //监听switch开关
        form.on('switch(switchTest)', function (data) {
            var id = data.elem.name;
            var flag = data.elem.checked;
            if (flag) {
                $.ajax({
                    type: "post",
                    url: "${ctx}/user/changeUserStatus",
                    data: {
                        "id": id,
                        "status": 0
                    },
                    success: function (result) {
                        if (result.success) {
                            layer.msg('禁用用户成功！', {icon: 1, time: 2000});
                        } else {
                            layer.msg('禁用用户失败！请重试！', {icon: 5, time: 2000});
                        }
                    }
                });
            } else {
                $.ajax({
                    type: "post",
                    url: "${ctx}/user/changeUserStatus",
                    data: {
                        "id": id,
                        "status": 1
                    },
                    success: function (result) {
                        if (result.success) {
                            layer.msg("解禁用户成功！", {icon: 1, time: 2000});
                        } else {
                            layer.msg("解禁用户失败！请重试！", {icon: 5, time: 2000});
                        }
                    }
                });
            }
        });


    });
</script>
</body>
</html>
