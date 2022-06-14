<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>我的数码</title>
    <link rel="stylesheet" href="${ctx}/statics/layuimini/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="icon" href="${ctx}/statics/layuimini/images/favicon.ico">
    <link type="text/css" rel="stylesheet" href="${ctx}/statics/front/user/css/style.css">
    <script src="${ctx}/statics/front/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/statics/front/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<style>
    .thumbImg {
        width: 70px;
        height: 70px;
    }

    img.error {
        display: inline-block;
        transform: scale(1);
        content: '';
        color: transparent;
    }

    img.error::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background: #f5f5f5 url(${ctx}/statics/front/user/images/break.png) no-repeat center / 50% 50%;
    }

    img.error::after {
        content: attr(alt);
        position: absolute;
        left: 0;
        bottom: 0;
        width: 100%;
        line-height: 2;
        background-color: rgba(0, 0, 0, .5);
        color: white;
        font-size: 12px;
        text-align: center;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
</style>
<body>
<%--顶部导航栏--%>
<%@include file="../../include/h_top.jsp" %>
<!--导航条-->
<%@include file="../../include/h_navigation.jsp" %>
<div class="width1200 center_yh hidden_yh font14" style="height: 40px;line-height: 40px;">
    <span>当前位置：</span><a href="${ctx}/index.html" class="c_66">首页</a>
    ><a href="#" class="c_66">个人中心</a>
    ><a href="#" class="c_66">个人信息</a>
</div>
<div class="width100 hidden_yh" style="background: #f0f0f0;padding-top: 34px;padding-bottom: 34px;">
    <div class="width1200 hidden_yh center_yh">
        <div id="vipNav">
            <a href="${ctx}/user/userCenter" class="on">个人信息</a>
            <a href="${ctx}/order/myOrder">我的订单</a>
            <a href="${ctx}/collect/myCollect">我的收藏</a>
            <a href="${ctx}/user/updatePwd">修改密码</a>
        </div>
        <div id="vipRight">
            <form action="${ctx}/user/updateUser" method="post" id="myf">
                <div class="hidden_yh bj_fff" style="width: 938px;border: 1px solid #ddd;">
                    <div class="width100 font24"
                         style="height: 60px;line-height: 60px;text-indent: 50px; background: #f5f8fa;border-bottom: 1px solid #ddd;">
                        基本信息
                    </div>
                    <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                        <div class="left_yh font16 tright" style="width: 120px;margin-top: 10px">
                            <font class="red">*</font>用户头像：
                        </div>
                        <input type="hidden" name="pic" id="pic">
                        <img class="thumbImg" alt="自行修改" onerror="this.classList.add('error');">
                    </div>
                    <div class="width100" style="height: 32px;line-height: 32px;margin-top: 45px;">
                        <div class="left_yh font16 tright" style="width: 120px;">
                            <font class="red">*</font>真实姓名：
                        </div>
                        <input type="text" name="realName" value="${user.realName}"
                               style="width: 243px;border: 1px solid #ddd;outline: none;height:30px;text-indent: 10px;">
                    </div>


                    <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                        <div class="left_yh font16 tright" style="width: 120px;">
                            <font class="red">*</font>性别：
                        </div>
                        <input type="radio" ${user.sex=='男'?'checked="checked"':''} name="sex" value="男">男
                        <input type="radio" ${user.sex=='女'?'checked="checked"':''} name="sex" value="女">女
                    </div>
                    <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                        <div class="left_yh font16 tright" style="width: 120px;">
                            <font class="red">*</font>邮箱：
                        </div>
                        <input type="text" name="email" value="${user.email}"
                               style="width: 243px;border: 1px solid #ddd;outline: none;height:30px;text-indent: 10px;">
                    </div>
                    <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                        <div class="left_yh font16 tright" style="width: 120px;">
                            <font class="red">*</font>手机号：
                        </div>
                        <input type="text" name="phone" value="${user.phone}"
                               style="width: 243px;border: 1px solid #ddd;outline: none;height:30px;text-indent: 10px;">
                    </div>
                    <div class="width100" style="height: 32px;line-height: 32px;margin-top: 25px;">
                        <div class="left_yh font16 tright" style="width: 120px;">
                            <font class="red">*</font>地址：
                        </div>
                        <input type="text" name="address" value="${user.address}"
                               style="width: 243px;border: 1px solid #ddd;outline: none;height:30px;text-indent: 10px;">
                    </div>
                    <div class="width100" style="height: 20px;line-height: 32px;margin-top: 20px;">
                        <a href="javascript:void(0)" class="left_yh block_yh font16 tcenter ff5802 sub"
                           style="width: 244px;height: 33px;line-height: 33px;margin-left: 120px;margin-bottom: 10px">保存</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="${ctx}/statics/front/layer/layer.js"></script>
<script type="text/javascript">
    <%--alert("${user.pic}");--%>
    layui.use(['jquery', 'upload'], function () {
        var $ = layui.jquery,
            upload = layui.upload;

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
                //给图片隐藏域赋值
                $("#pic").val(res.imagePath);

            }
        });
    });

    <%--alert('${user.pic}')--%>
    $(".thumbImg").attr("src", "/shop/upload/" + "${user.pic}");

    $(function () {
        $(".sub").click(function () {
            console.log("111" + $("#pic").val());
            layer.msg("修改成功", {offset: "t", icon: 1});
            setTimeout(function () {
                $("#myf").submit();
            }, 1000);
            //图片回显

        });
    });
</script>
<%@include file="../../include/h_footer.jsp" %>
</body>
</html>



















