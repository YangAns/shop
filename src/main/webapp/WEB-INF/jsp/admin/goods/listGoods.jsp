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
    <style>
        .thumbBox {
            height: 200px;
            overflow: hidden;
            border: 1px solid #e6e6e6;
            border-radius: 2px;
            cursor: pointer;
            position: relative;
            text-align: center;
            line-height: 200px;
            width: 210px;
        }

        .thumbImg {
            max-width: 100%;
            max-height: 100%;
            border: none;
        }

        .thumbBox:after {
            position: absolute;
            width: 100%;
            height: 100%;
            line-height: 200px;
            z-index: -1;
            text-align: center;
            font-size: 20px;
            content: "缩略图";
            left: 0;
            top: 0;
            color: #9F9F9F;
        }


        /*.layui-table-cell {*/
        /*    height: auto !important;*/
        /*    !*height: 80px;*!*/
        /*    white-space: normal;*/
        /*}*/


    </style>
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
                            <label class="layui-form-label">商品名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="name" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">商品类型</label>
                            <div class="layui-input-inline">
                                <select name="typeIdOne" id="typeIdOne" autocomplete="off" class="layui-input">
                                    <option value="">全部</option>
                                </select>
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

        <%-- 表格工具栏 --%>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"><i
                        class="layui-icon layui-icon-add-1"></i>添加
                </button>
            </div>
        </script>

        <%-- 数据表格 --%>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <%-- 行工具栏 --%>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit"><i
                    class="layui-icon layui-icon-edit"></i>编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete"><i
                    class="layui-icon layui-icon-close"></i>删除</a>
        </script>


        <%-- 添加和修改窗口 --%>
        <div style="display: none;padding: 5px" id="addOrUpdateWindow">
            <form class="layui-form" style="width:90%;" id="dataFrm" lay-filter="dataFrm">
                <!-- 隐藏域，保存房型id -->
                <input type="hidden" name="id">
                <div class="layui-col-md12 layui-col-xs12">
                    <div class="layui-row layui-col-space10">
                        <div class="layui-col-md9 layui-col-xs7">
                            <div class="layui-form-item magt3" style="margin-top: 8px;">
                                <label class="layui-form-label">商品名称</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="name" lay-verify="required"
                                           placeholder="请输入商品名称">
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <label class="layui-form-label">商品价格</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="price" lay-verify="required"
                                           placeholder="请输入商品价格">
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <label class="layui-form-label">商品库存</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="num" lay-verify="required"
                                           placeholder="请输入商品库存">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">商品类型</label>
                                    <div class="layui-input-inline">
                                        <select name="typeIdTwo" id="typeIdTwo" lay-verify="required">
                                            <option value="">请选择类型</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">添加时间</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="addTime" id="addTime" readonly lay-verify="required"
                                               autocomplete="off" placeholder="请选择时间" class="layui-input">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3 layui-col-xs5">
                            <div class="layui-upload-list thumbBox mag0 magt3">
                                <input type="hidden" name="pic" id="pic" value="images/defaultimg.jpg">
                                <img class="layui-upload-img thumbImg" src="/upload/images/defaultimg.jpg">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">商品详情</label>
                        <div class="layui-input-block">
                            <textarea id="details" name="details" style="display: none;"></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block" style="text-align: center;">
                            <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit" id="doSubmit"><span
                                    class="layui-icon layui-icon-add-1"></span>提交
                            </button>
                            <button type="reset" class="layui-btn layui-btn-warm"><span
                                    class="layui-icon layui-icon-refresh-1"></span>重置
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

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

        laydate.render({
            elem: '#addTime',//指定元素
            position: "abolute",
        });

        //渲染表格组件
        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${ctx}/admin/goods/list',
            toolbar: '#toolbarDemo',
            height: "full",
            cols: [[
                {field: 'id', title: '编号', Width: 50, align: "center"},
                {
                    field: 'pic', title: '商品图片', width: 120, align: "center", templet: function (d) {
                        return '<img  src="/shop/upload/' + d.pic + '"  width="50px" height="50px" onclick="showBigImage(this)">'
                    }
                },
                {field: 'name', title: '商品名称', Width: 200, align: "center"},
                {field: 'price', title: '价格',Width:10,sort:true ,align: "center"},
                {field: 'num', title: '库存',Width:10,sort:true ,align: "center"},
                {
                    field: 'typeOne', title: '一级分类', Width: 100, align: "center", templet: function (d) {
                        return d.typeOne.typeName;
                    }
                },
                {
                    field: 'typeTwo', title: '二级分类', Width: 100, align: "center", templet: function (d) {
                        return d.typeTwo.typeName;
                    }
                },
                // {field: 'buyNum', title: '销量', minWidth: 50, align: "center"},
                {field: 'addTime', title: '添加时间', Width: 120, align: "center"},
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
            },
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

        //发送Ajax请求查询所有一级类型
        $.ajax({
            url: "${ctx}/admin/goodstype/findOneAll",
            type: "get",
            dataType: "json",
            success: function (result) {
                console.log(result);
                var html = " ";
                for (var i = 0; i < result.length; i++) {
                    html += "<option value='" + result[i].id + "'>" + result[i].typeName + "</option>"
                }
                //将网页代码追加到下拉列表中
                $("#typeIdOne").append(html);
                //重新渲染下拉列表
                form.render("select");
            }
        });

        //发送Ajax请求查询所有二级类型
        $.ajax({
            url: "${ctx}/admin/goodstype/findTwoAll",
            type: "get",
            dataType: "json",
            success: function (result) {
                console.log(result);
                var html = " ";
                for (var i = 0; i < result.length; i++) {
                    html += "<option value='" + result[i].id + "'>" + result[i].typeName + "</option>"
                }
                //将网页代码追加到下拉列表中
                $("#typeIdTwo").append(html);
                //重新渲染下拉列表
                form.render("select");
            }
        });


        //渲染文件上传区域
        upload.render({
            elem: ".thumbImg",//绑定元素
            url: '/shop/file/uploadFile',//文件上传地址
            acceptMime: 'image/*',//规定打开文件选择框时，筛选出的文件类型
            field: 'file',//文件上传的字段值，等同于input标签的name属性值，该值必须与控制器中的方法参数名一致
            method: "post",//提交方式
            //文件上传成功后的回调函数
            done: function (res, index, upload) {
                //设置图片回显路径
                $(".thumbImg").attr("src", res.data.src);
                $('.thumbBox').css("background", "#fff");
                //给图片隐藏域赋值
                $("#pic").val(res.imagePath);
            }
        });

        //监听头部工具栏事件
        table.on("toolbar(currentTableFilter)", function (obj) {
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
            }
        });

        var url;//提交地址
        var mainIndex;//打开窗口的索引
        var detailIndex;//富文本编辑器的索引


        /**
         * 打开添加窗口
         */
        function openAddWindow() {
            // var he = document.body.clientHeight;
            // he = (he - 30) + 'px';
            mainIndex = layer.open({
                type: 1,//打开类型
                title: "添加商品",//窗口标题
                area: ["600px", "200px"],//窗口宽高
                content: $("#addOrUpdateWindow"),//引用的内容窗口
                // offset: 't',
                maxmin: true,//窗口显示最大最小化
                success: function () {
                    //清空表单数据
                    $("#dataFrm")[0].reset();
                    //添加的提交请求
                    url = "${ctx}/admin/goods/addGoods";
                    //重置默认图片,注意：显示图片必须在图片名称前加上/hotel/show
                    $(".thumbImg").attr("src", "/shop/upload/images/defaultimg.jpg");
                    //重置图片隐藏域的值
                    $("#pic").val("images/defaultimg.jpg");
                }
            });
            //设置窗口打开时最大化显示
            layer.full(mainIndex);
            //初始化富文本编辑器
            detailIndex = layedit.build("details", {
                // height:80,

                tool: [
                    'strong' //加粗
                    ,'italic' //斜体
                    ,'underline' //下划线
                    ,'del' //删除线
                    ,'|' //分割线
                    ,'left' //左对齐
                    ,'center' //居中对齐
                    ,'right' //右对齐
                    ,'link' //超链接
                    ,'unlink' //清除链接
                    ,'image' //插入图片
                ],
                uploadImage: {
                    url: "/shop/file/uploadFile",//文件上传地址
                    type: "post"//提交方式
                }
            });
        }


        /**
         * 打开修改窗口
         */
        function openUpdateWindow(data) {
            // var he = document.body.clientHeight;
            // he = (he - 80) + 'px';
            mainIndex = layer.open({
                type: 1,//打开类型
                title: "修改商品",//窗口标题
                area: ["600px", "200px"],//窗口宽高
                offset: 't',
                content: $("#addOrUpdateWindow"),//引用的内容窗口
                maxmin: true,
                success: function () {
                    //表单数据回显
                    form.val("dataFrm", data);
                    //修改的提交请求
                    url = "${ctx}/admin/goods/updateGoods";
                    //图片回显
                    $(".thumbImg").attr("src", "/shop/upload/" + data.pic);
                    //图片隐藏域的值回显
                    $("#pic").val(data.pic);
                    console.log(data.pic);
                }
            });
            //设置窗口打开时最大化显示
            layer.full(mainIndex);
            //初始化富文本编辑器
            detailIndex = layedit.build("details", {
                tool: [
                    'strong' //加粗
                    ,'italic' //斜体
                    ,'underline' //下划线
                    ,'del' //删除线
                    ,'|' //分割线
                    ,'left' //左对齐
                    ,'center' //居中对齐
                    ,'right' //右对齐
                    ,'link' //超链接
                    ,'unlink' //清除链接
                    ,'image' //插入图片
                ],
                uploadImage: {
                    url: "/shop/file/uploadFile",//文件上传地址
                    type: "post"//提交方式
                }
            });
        }


        function deleteById(data) {
            console.log(data);
            //提示用户是否删除
            layer.confirm("确定要删除[<font color='red'>" + data.name + "</font>]吗",
                {icon: 3, title: '提示',offset:['100px','400px']}, function (index) {
                    //发送ajax请求进行删除
                    $.post("${ctx}/admin/goods/deleteById", {"id": data.id}, function (result) {
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


        //监听表单提交事件
        form.on("submit(doSubmit)", function (data) {
            //将富文本编辑器的内容同步到文本域textarea中
            layedit.sync(detailIndex);
            console.log($("#dataFrm").serialize());
            //$("#dataFrm").serialize()：一次性获取表单的数据，要求表单标签必须有name属性值
            $.post(url, $("#dataFrm").serialize(), function (result) {
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
            }, "json");
            //禁止页面刷新
            return false;
        });

         window.showBigImage=function (e) {
            layer.open({
                type: 1,
                title: false,
                closeBtn: 0,
                offset:"t",
                shadeClose: true, //点击阴影关闭
                area: [$(e).width + 'px', $(e).height + 'px'], //宽高
                content: "<img src=" + $(e).attr('src') + " />"
            });
        }
    });
</script>

</body>
</html>
