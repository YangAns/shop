package com.yang.interceptor;

import com.yang.utils.SystemConstant;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录拦截器
 */
@Component
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (request.getSession().getAttribute(SystemConstant.LOGINUSER) == null) {
            //如果没有登录，则去到登录页面
            response.sendRedirect(request.getContextPath() + "/admin/login.html");
            return false;//验证失败，进行拦截
        }
        //验证通过
        return true;
    }
}

