package com.ly.bigdata.Interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 拦截器
public class MyHandlerInterceptor implements HandlerInterceptor {
    /**
     * 拦截（Controller方法调用之前）
     *
     * @param request  request
     * @param response response
     * @param o        o
     * @return 通过与否
     * @throws Exception 异常处理
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object
            o) throws Exception {
        String requestURI = request.getRequestURI();

        if (request.getSession().getAttribute("admin_session") != null) {//管理员已经登录，可以去任何界面，放行
            System.err.println("管理员已经登陆，放行所有接口====" + requestURI);
            return true;
        }
        if (request.getSession().getAttribute("user_session") == null&&request.getSession().getAttribute("admin_session")==null) {
            System.err.println("管理员未登录，用户也未登录，禁行所有接口====" + requestURI);
            // 拦截至登陆页面
            request.getRequestDispatcher("/tologin").forward(request, response);
            return false;
        }
        if (request.getSession().getAttribute("user_session") != null&&request.getSession().getAttribute("admin_session")==null) {
            System.err.println("管理员未登录，但用户登录，放行前台接口====" + requestURI);//实际放行了所有接口，待优化
            return true;
        }

        if (request.getSession().getAttribute("user_session") != null&&request.getSession().getAttribute("admin_session")!=null) {
            System.err.println("管理员登录，用户登录，放行所有接口====" + requestURI);
            return true;
        }
        return false;
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
