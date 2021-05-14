package com.ly.bigdata.config;

import com.ly.bigdata.Interceptor.MyHandlerInterceptor;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

// 拦截器配置类
@Component
public class MyHandlerInterceptorConfig extends WebMvcConfigurerAdapter {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        /**
         * 这里的addPathPatterns("/**")为配置需要拦截的方法“/**”代表所有，而后excludePathPatterns("/user/toLogin")等方法为排除哪些方法不进行      拦截
         */
        //第一个拦截器
        registry.addInterceptor(new MyHandlerInterceptor()).addPathPatterns("/**").excludePathPatterns("/tologin").excludePathPatterns
                ("/toregister").excludePathPatterns("/forget").excludePathPatterns("/findOutPwd").excludePathPatterns("/getCode").excludePathPatterns("/isRegistered2").excludePathPatterns("/").excludePathPatterns("/login").excludePathPatterns//查看控制台访问路径里面没有static，因为我的静态文件根本没有static这一层，所以添加static根本没用
                ("/static/**").excludePathPatterns("/agreement_files/**").excludePathPatterns//排除静态资源
                ("/bootstrap-3.3.7-dist/**").excludePathPatterns//排除静态资源
                ("/error/**").excludePathPatterns//排除静态资源
                ("/img/**").excludePathPatterns("/layuiadmin/**").excludePathPatterns//排除静态资源
                ("/layuimini/**").excludePathPatterns("/qiantai_user/**").excludePathPatterns("/vue/**").excludePathPatterns("/agreement.html");

        //第二个拦截器
/*        registry.addInterceptor(new MyHandlerInterceptor2()).addPathPatterns("/**").excludePathPatterns("/tologin").excludePathPatterns
                ("/toregister").excludePathPatterns("/forget").excludePathPatterns("/").excludePathPatterns("/login").excludePathPatterns//查看控制台访问路径里面没有static，因为我的静态文件根本没有static这一层，所以添加static根本没用
                ("/static/**").excludePathPatterns("/agreement_files/**").excludePathPatterns//排除静态资源
                ("/bootstrap-3.3.7-dist/**").excludePathPatterns//排除静态资源
                ("/error/**").excludePathPatterns//排除静态资源
                ("/img/**").excludePathPatterns("/layuiadmin/**").excludePathPatterns//排除静态资源
                ("/layuimini/**").excludePathPatterns("/qiantai_user/**").excludePathPatterns("/vue/**").excludePathPatterns("/agreement.html").excludePathPatterns("/**");//废弃此拦截器*/
        super.addInterceptors(registry);
    }
}