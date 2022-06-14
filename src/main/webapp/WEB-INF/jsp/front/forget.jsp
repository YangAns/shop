<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
</head>
<script src="${ctx}/statics/front/jQuery-1.12.4.js"></script>
<body>
<form  method="post">
    <fieldset>
        <div>
            <input placeholder="邮箱" id="email" name="email" type="email" required="" autofocus=""/>
            <a href="javascript:void(0)" id="val">发送验证码</a>
        </div>
        <div>
            <input placeholder="验证码" id="emailCode" name="code" type="text" required=""/>
        </div>
        <div>
            <input placeholder="密码" id="pwd1" name="password" type="password" required="" onkeyup="checkLength()"/>
            <span id="spanLen"></span>
        </div>
        <div>
            <input placeholder="确认密码" id="pwd2" name="password2" type="password" required="" onblur="checkPSW()"/>
            <span id="pswInfo" style="color: #c41a15;"></span>
        </div>
        <button id="btforget" type="button">更新密码</button>
    </fieldset>
</form>

<script>
    function checkLength() {
        var pwd1 = document.getElementById("pwd1").value;
        var spanLen = document.getElementById("spanLen");
        if (pwd1.length <= 3 && pwd1.length > 0)
            spanLen.innerHTML = "密码强度：弱";
        else if (pwd1.length <= 6)
            spanLen.innerText = "密码强度：中";
        else
            spanLen.innerText = "密码强度：强";
    }


    function checkPSW() {
        var pwd1 = document.getElementById("pwd1").value;
        var pwd2 = document.getElementById("pwd2").value;
        var pswInfo = document.getElementById("pswInfo");
        if (pwd1 != pwd2) {
            pswInfo.innerText = "两次密码不同";
            document.getElementById("btregister").disabled = true;
        } else {
            pswInfo.innerText = "";
            document.getElementById("btregister").disabled = false;
        }
    }

    $("#val").click(function () {
        $.post("/user/sendCode", {"email": $("#email").val()}, function (result) {
            if (result.success) {
                alert(result.message)
            } else {
                alert(result.message)
            }
        }, "json");
    });

    $("#btforget").click(function () {
        $.post("/user/updatePwdByEmail",
            {
                "email": $("#email").val(),
                "password":$("#pwd1").val(),
                "code":$("#emailCode").val()
            }
            , function (result) {
                if (result.success) {
                    alert(result.message)
                } else if(result.success=="codeError") {
                    alert(result.message)
                }else{
                    alert(result.message)
                }
            }, "json");
    })
</script>

</body>
</html>
