<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>公告详情</title>
    <link rel="stylesheet" href="${ctx}/statics/layuimini/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="icon" href="${ctx}/statics/layuimini/images/favicon.ico">
    <link type="text/css" rel="stylesheet" href="${ctx}/statics/front/user/css/style.css">
    <script src="${ctx}/statics/front/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/statics/front/user/js/jquery.luara.0.0.1.min.js"></script>
</head>
<body>
<%@include file="../../include/h_top.jsp" %>
<!--导航条-->
<%@include file="../../include/h_navigation.jsp" %>


<div class="width100 hidden_yh" style="background: #f0f0f0;padding-top: 34px;padding-bottom: 34px;">
    <div class="width1200 hidden_yh center_yh">
        <div id="vipRight" style="width: 1200px">
            <div class="hidden_yh bj_fff" style="width: 1198px;border: 1px solid #ddd;">
                <div class="width100" style="height: 50px;line-height: 50px;width: 200px;text-align: center;">
                    ${notice.title}
                </div>
                <div class="hidden_yh" style="padding: 20px;width: 1100px;margin: 0 auto">
                    <div class="width100 hidden_yh" style="border-bottom: 1px dashed #ddd;padding-top: 10px;padding-bottom: 10px;">
                        <div class="left_yh" style="width: 100%;color: black">
                            ${notice.content}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../../include/h_footer.jsp" %>
</body>
</html>



















