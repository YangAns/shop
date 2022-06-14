<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<style>
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
<div class="width100" style="height: 25px;background: #f0f0f0;">
    <div class="width1200 center_yh font14 c_66" style="height: 25px;line-height: 25px;">
        <font class="left_yh">欢迎来到乐享数码商城！</font>
        <div class="right_yh" id="fast_jump">
            <c:if test="${sessionScope.user.id!=null}">
                <a id="box1" href="#">欢迎您：${sessionScope.user.userName}</a>
                <b></b>
            </c:if>
            <c:if test="${sessionScope.user.id==null}">
                <a href="${ctx}/user/toLogin">亲,请登录</a>
                <b></b>
                <a href="${ctx}/user/toReg">免费注册</a>
                <b></b>
            </c:if>
            <a href="${ctx}/cart/showMyCart">购物车</a>
            <a href="${ctx}/user/userCenter">我的数码</a>
        </div>
    </div>
</div>
<div class="width100 hidden_yh">
    <div class="width1200 center_yh hidden_yh">
        <a href="${ctx}/index.html" class="block_yh left_yh">
            <%--<img src="${ctx}/statics/front/images/logo.png" alt="" style="height: 70px">--%>
        </a>
        <div style="height:36px;width:490px;border:2px solid #dd4545;margin: 0 auto;margin-top: 20px">
            <form action="${ctx}/findFrontGoods" method="post">
                <input type="text" placeholder="关键词查询" style="padding: 18px" class="search" name="name">
                <input type="submit" style="height: 36px" class="btnSearh" value="搜索">
            </form>
        </div>
    </div>
</div>
<style>
</style>
<script src="${ctx}/statics/layuimini/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    // console.log($("#pic").val())
    layui.use(['dropdown', 'jquery', 'layer'], function () {
        var dropdown = layui.dropdown,
            layer = layui.layer,
            $ = layui.jquery;

        if (${sessionScope.user.userName!=null}) {
            $.ajax({
                url: "${ctx}/user/findUserPicById",
                type: "post",
                success: function (result) {
                    pic(result.pic)
                }
            });
        }

        function pic(pic) {
            dropdown.render({
                elem: '#box1' //可绑定在任意元素中，此处以上述按钮为例
                , trigger: "hover"
                , data: [{
                    id: 100
                    ,
                    href: '${ctx}/user/userCenter'
                    ,
                    templet: '<div style="width:10px;"><img src="/shop/upload/' + pic + '" style="width: 40px;height: 40px;border-radius: 50%;" alt="未设置" onerror="this.classList.add(\'error\');"/></div>'
                }, {
                    title: '退出'
                    , href: '${ctx}/user/loginOut'
                }]
            });
        }
    });
</script>