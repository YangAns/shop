<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                            <label class="layui-form-label">姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="realName" autocomplete="off" class="layui-input">
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

        <!-- 表格工具栏 -->
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添加 </button>
            </div>
        </script>

        <!-- 数据表格 -->
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <!-- 行工具栏 -->
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete"><i class="layui-icon layui-icon-close"></i>删除</a>
            <button class="layui-btn layui-btn-xs" lay-event="grantRole"><i class="layui-icon layui-icon-edit"></i>分配角色 </button>
        </script>

        <!-- 添加和修改窗口 -->
        <div style="display: none;padding: 5px" id="addOrUpdateWindow">
            <form class="layui-form" style="width:90%;" id="dataFrm" lay-filter="dataFrm">
                <div class="layui-form-item">
                    <label class="layui-form-label">登录名称</label>
                    <div class="layui-input-block">
                        <!-- 编号 -->
                        <input type="hidden" name="id">
                        <input type="text" name="loginName" lay-verify="required" autocomplete="off"
                               placeholder="请输入登录名称" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密码</label>
                    <div class="layui-input-block">
                        <input type="password" name="password" lay-verify="required" autocomplete="off"
                               placeholder="请输入密码" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">真实姓名</label>
                    <div class="layui-input-block">
                        <input type="text" name="realName" lay-verify="required" autocomplete="off"
                               placeholder="请输入真实姓名" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">手机号</label>
                    <div class="layui-input-block">
                        <input type="text" name="phone" lay-verify="required" autocomplete="off"
                               placeholder="请输入手机号" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item layui-row layui-col-xs12">
                    <div class="layui-input-block" style="text-align: center;">
                        <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit"><span
                                class="layui-icon layui-icon-add-1"></span>提交
                        </button>
                        <button type="reset" class="layui-btn layui-btn-warm"><span
                                class="layui-icon layui-icon-refresh-1"></span>重置
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- 分配角色弹出层 -->
        <div style="display: none;padding: 5px" id="selectUserRoleDiv">
            <table class="layui-hide" id="roleTable" lay-filter="roleTable"></table>
        </div>

    </div>
</div>
<script src="${ctx}/statics/layuimini/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table','laydate','jquery'], function () {
        var $ = layui.jquery,
            form = layui.form,
            laydate = layui.laydate,
            table = layui.table;


        //渲染表格组件
        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${ctx}/admin/adminuser/list',
            toolbar: '#toolbarDemo',
            cols: [[
                {field: 'id', width: 100, title: '编号', align: "center"},
                {field: 'loginName', width: 120, title: '管理员账号', align: "center"},
                {field: 'realName', width: 120, title: '真实姓名', align: "center"},
                {field: 'phone', width: 120, title: '手机号', align: "center"},
                {field: 'createDate', width: 180, title: '创建时间', align: "center"},
                {title: '操作', minWidth: 120, toolbar: '#currentTableBar', align: "center"}
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
            tableIns.reload({
                where: data.field,
                page: {
                    curr: 1
                }
            });
            return false;
        });


        //监听头部工具栏事件
        table.on("toolbar(currentTableFilter)",function (obj) {
            switch (obj.event) {
                case "add"://添加按钮
                    openAddWindow();//打开添加窗口
                    break;
            }
        });

        //监听行工具栏事件
        table.on("tool(currentTableFilter)", function (obj) {
            switch (obj.event) {
                case "edit"://编辑按钮
                    openUpdateWindow(obj.data);//打开修改窗口
                    break;
                case "delete"://删除按钮
                    deleteById(obj.data);
                    break;
                case "grantRole":
                    grantRole(obj.data)
            }
        });


        var url;//提交地址
        var mainIndex;//打开窗口的索引
        var flag="";
        /**
         * 打开添加窗口
         */
        function openAddWindow() {
            mainIndex = layer.open({
                type: 1,//打开类型
                title: "添加管理员",//窗口标题
                area: ["800px", "400px"],//窗口宽高
                content: $("#addOrUpdateWindow"),//引用的内容窗口
                success: function () {
                    //清空表单数据
                    $("#dataFrm")[0].reset();
                    //添加的提交请求
                    url = "${ctx}/admin/adminuser/addAdmin";
                    flag="add"
                }
            });
        }

        /**
         * 打开修改窗口
         * @param data 当前行的数据
         */
        function openUpdateWindow(data) {
            mainIndex = layer.open({
                type: 1,//打开类型
                title: "修改类型",//窗口标题
                area: ["800px", "400px"],//窗口宽高
                content: $("#addOrUpdateWindow"),//引用的内容窗口
                success: function () {
                    //表单数据回显menu
                    form.val("dataFrm", data);//参数1：lay-filter值 参数2：回显的数据
                    //修改的提交请求
                    url = "/admin/adminuser/updateAdmin";
                    flag="update"
                }
            });
        }

        function deleteById(data) {
            //提示用户是否删除该类型
            layer.confirm("确定要删除[<font color='red'>" + data.realName + "</font>]吗",
                {icon: 3, title: '提示'}, function (index) {
                    //发送ajax请求进行删除
                    $.post("${ctx}/admin/adminuser/deleteById", {"id": data.id}, function (result) {
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


        /**
         * 分配角色
         * @param data
         */
        function grantRole(data) {
            mainIndex = layer.open({
                type: 1,//打开类型
                title: "分配[<font color='red'>"+data.realName+"</font>]角色",//窗口标题
                area: ["800px", "400px"],//窗口宽高
                content: $("#selectUserRoleDiv"),//引用的内容窗口
                btn: ['<i class="layui-icon layui-icon-ok"></i>确定', '<i class="layui-icon layui-icon-close"></i>取消'],
                yes: function(index, layero){
                    //获取选中行
                    var checkStatus = table.checkStatus('roleTable');
                    //判断是否有选中行
                    if(checkStatus.data.length>0){
                        //定义数组，保存选中的角色ID
                        var idArr = [];
                        //获取选中的角色ID
                        for (var i = 0; i < checkStatus.data.length; i++) {
                            idArr.push(checkStatus.data[i].id);
                        }
                        //将数组使用,分隔
                        var ids = idArr.join(",");//将数组拼接成字符串
                        //发送请求
                        $.post("${ctx}/admin/adminuser/saveAdminRole",{"roleIds":ids,"adminId":data.id},function(result){
                            layer.msg(result.message,{icon:1});
                        },"json");
                        //关闭当前窗口
                        layer.close(mainIndex);
                    }else{
                        layer.msg("请选择要分配的角色");
                    }
                }
                ,btn2: function(index, layero){
                    //按钮【按钮二】的回调
                    //return false 开启该代码可禁止点击该按钮关闭
                },
                success: function () {
                    //显示角色列表的数据表格
                    initTableData(data);
                }
            });
        }

        /**
         * 初始化角色表格数据
         * @param data
         */
        function initTableData(data) {
            table.render({
                elem: '#roleTable',
                url: '${ctx}/admin/role/initRoleListByAdminId?id='+data.id,
                cols: [[
                    {type: "checkbox", width: 50},
                    {field: 'id', minWidth: 100, title: '角色编号', align: "center"},
                    {field: 'rolename', minWidth: 120, title: '角色名称', align: "center"},
                    {field: 'roledesc', minWidth: 120, title: '角色描述', align: "center"}
                ]]
            });
        }


        //监听表单提交事件
        form.on("submit(doSubmit)", function (data) {

            console.log(flag);
            console.log(data.field);

            if(flag=="add"){
                //验证用户名是否重复
                $.get("${ctx}/admin/adminuser/findAdminByLoginName",{"loginName":data.field.loginName},function (result) {
                    if (result.success){
                        layer.msg(result.message,{icon:5});
                    }else{
                        $.ajax({
                            url: url,
                            type: "post",
                            data: data.field,
                            success: function (result) {
                                console.log(result.success);
                                if (result.success) {
                                    layer.msg(result.message,{icon:1});
                                    //刷新数据表格
                                    tableIns.reload();
                                    //关闭窗口
                                    layer.close(mainIndex);
                                }else{
                                    //提示信息
                                    layer.msg(result.message,{icon:5});
                                }
                            }
                        });
                    }
                });
            }else{
                $.ajax({
                    url: url,
                    type: "post",
                    data: data.field,
                    success: function (result) {
                        console.log(result.success);
                        if (result.success) {
                            layer.msg(result.message,{icon:1});
                            //刷新数据表格
                            tableIns.reload();
                            //关闭窗口
                            layer.close(mainIndex);
                        }else{
                            //提示信息
                            layer.msg(result.message,{icon:5});
                        }
                    }
                });
            }
            //禁止页面刷新
            return false;
        });





    });

</script>

</body>
</html>

