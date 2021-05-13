/*
package com.ly.bigdata.Interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 拦截器
public class MyHandlerInterceptor2 implements HandlerInterceptor {
    */
/**
     * 拦截（Controller方法调用之前）
     *
     * @param request  request
     * @param response response
     * @param o        o
     * @return 通过与否
     * @throws Exception 异常处理
     *//*

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object
            o) throws Exception {
        String requestURI = request.getRequestURI();
        System.err.println("拦截器2======" + requestURI);

        if (request.getSession().getAttribute("user_session") == null) {
            // 拦截至登陆页面
            request.getRequestDispatcher("/tologin").forward(request, response);
            // false为不通过
            return false;
        }
        // true为通过
        return true;
    }

    // 此方法为处理请求之后调用（调用过controller方法之后，跳转视图之前）
    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o,
                           ModelAndView modelAndView) throws Exception {

    }

    // 此方法为整个请求结束之后进行调用
    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
                                Object o, Exception e) throws Exception {

    }
}
*/
