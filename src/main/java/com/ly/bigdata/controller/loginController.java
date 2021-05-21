package com.ly.bigdata.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ly.bigdata.po.Admin;
import com.ly.bigdata.po.SysUservisit;
import com.ly.bigdata.po.User;
import com.ly.bigdata.po.UservisitInf;
import com.ly.bigdata.service.AdminService;
import com.ly.bigdata.service.SysUservisitService;
import com.ly.bigdata.service.UserService;
import com.ly.bigdata.utils.NumberUtil;
import com.ly.bigdata.utils.SendMessageUtil;
import eu.bitwalker.useragentutils.Browser;
import eu.bitwalker.useragentutils.OperatingSystem;
import eu.bitwalker.useragentutils.UserAgent;
import eu.bitwalker.useragentutils.Version;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class loginController {
    @Autowired
    private UserService userService;
    @Autowired
    private AdminService adminService;
    @Autowired
    private SysUservisitService sysUservisitService;
    @Autowired
    private StringRedisTemplate redisTemplate;

    @ResponseBody
    @RequestMapping("/login")
    public Object login(String loginname, String password, String identity, String remember,
                        HttpSession session, HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        if (remember != null) {//勾选了记住密码
            Cookie pwd = new Cookie("pwd", password);
            Cookie name = new Cookie("name", loginname);
            pwd.setMaxAge(60 * 60 * 24 * 7);//记住密码一周
            name.setMaxAge(60 * 60 * 24 * 7);//记住密码一周
            response.addCookie(pwd);
            response.addCookie(name);
        }

        if ("用户".equals(identity)) {
            QueryWrapper<User> wrapper = new QueryWrapper<>();
            //MD5加密
            String pwd = DigestUtils.md5DigestAsHex(password.getBytes());
            wrapper.eq("loginname", loginname).eq("password", pwd);
            User user = userService.getOne(wrapper);
            if (user != null) {

                //todo 收集浏览器用户登录信息,已实现
                getClientInfo(request,loginname);
                //把当前用户放入session
                session.setAttribute("user_session", user);
                Map<String, Object> map = new HashMap<>();
                map.put("data", "true");
                map.put("code", 0);
                map.put("msg", "用户");
                return map;
            } else {
                System.err.println("===用户名密码不正确===========================");
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false");
                map.put("code", 0);
                map.put("msg", "用户");
                return map;
            }

        } else {
            QueryWrapper<Admin> wrapper = new QueryWrapper<>();
            //MD5加密
            String pwd = DigestUtils.md5DigestAsHex(password.getBytes());
            wrapper.eq("loginname", loginname).eq("password", pwd);
            Admin admin = adminService.getOne(wrapper);
            if (admin != null) {
                //把当前管理员放入session
                session.setAttribute("admin_session", admin);

                Map<String, Object> map = new HashMap<>();
                map.put("data", "true");
                map.put("code", 0);
                map.put("msg", "管理员");
                return map;
            } else {
                System.err.println("===用户名密码不正确===========================");
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false");
                map.put("code", 0);
                map.put("msg", "管理员");
                return map;
            }
        }
    }


    //忘记密码
    @RequestMapping("/forget")
    public String repassword() {
        return "forget";
    }

    //获取短信验证码
    @ResponseBody
    @RequestMapping("/getCode")
    public void getCode(String phone, HttpSession session) {
        System.err.println("正在获取短信验证码");
        String forNumber = NumberUtil.getForNumber();
        session.setAttribute("forNumber", forNumber);
        String[] datas = {forNumber, "1分钟", "变量3"};
        SendMessageUtil.sendMsg(phone, datas);
    }

    //找回密码
    @ResponseBody
    @RequestMapping("/findOutPwd")
    public Object findOutPwd(HttpSession session, String vercode, String phone, String identity) {
        //判断修改密码的身份
        if ("用户".equals(identity)) {
            //校验用户是否存在
            QueryWrapper<User> wrapper = new QueryWrapper<>();
            wrapper.eq("phone", phone);
            User user = userService.getOne(wrapper);
            if (user != null) {
                session.setAttribute("updPwdPeople", user);//为了下一步的找回密码
                session.setAttribute("PeopleIdentity", identity);//为了下一步的找回密码
                String forNumber = (String) session.getAttribute("forNumber");
                if (forNumber.equals(vercode)) {
                    //验证通过，清除session中的验证码
                    session.removeAttribute("forNumber");
                    Map<String, Object> map = new HashMap<>();
                    map.put("data", "true");
                    map.put("code", 0);
                    map.put("msg", user.getLoginname());
                    return map;
                } else {
                    Map<String, Object> map = new HashMap<>();
                    map.put("data", "false");
                    map.put("code", 0);
                    map.put("msg", "用户");
                    return map;
                }
            } else {
                //该手机号不存在对应的用户
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false2");
                map.put("code", 0);
                map.put("msg", "该手机号不存在对应的用户");
                return map;
            }


        } else {

            //校验管理员是否存在
            QueryWrapper<Admin> wrapper = new QueryWrapper<>();
            wrapper.eq("phone", phone);
            Admin admin = adminService.getOne(wrapper);
            if (admin != null) {
                session.setAttribute("updPwdPeople", admin);//为了下一步的找回密码
                session.setAttribute("PeopleIdentity", identity);//为了下一步的找回密码
                String forNumber = (String) session.getAttribute("forNumber");
                if (forNumber.equals(vercode)) {
                    //验证通过，清除session中的验证码
                    session.removeAttribute("forNumber");
                    Map<String, Object> map = new HashMap<>();
                    map.put("data", "true");
                    map.put("code", 0);
                    map.put("msg", admin.getLoginname());
                    return map;
                } else {
                    Map<String, Object> map = new HashMap<>();
                    map.put("data", "false");
                    map.put("code", 0);
                    map.put("msg", "管理员");
                    return map;
                }
            } else {
                //该手机号不存在对应的管理员
                System.err.println("该手机号不存在对应的管理员");
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false3");
                map.put("code", 0);
                map.put("msg", "该手机号不存在对应的管理员");
                return map;
            }
        }
    }

    //重置新密码
    @ResponseBody
    @RequestMapping("/ResetPwd")
    public Object ResetPwd(HttpSession session, String password) {

        String peopleIdentity = (String) session.getAttribute("PeopleIdentity");
        if ("用户".equals(peopleIdentity)) {
            User user = (User) session.getAttribute("updPwdPeople");

            //MD5加密
            String s = DigestUtils.md5DigestAsHex(password.getBytes());
            user.setPassword(s);
            boolean a = userService.saveOrUpdate(user);
            if (a = true) {
                Map<String, Object> map = new HashMap<>();
                map.put("data", "true");
                map.put("code", 0);
                map.put("msg", "");
                return map;
            } else {
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false");
                map.put("code", 0);
                map.put("msg", "");
                return map;
            }


        } else {
            Admin admin = (Admin) session.getAttribute("updPwdPeople");

            //MD5加密
            String s = DigestUtils.md5DigestAsHex(password.getBytes());
            admin.setPassword(s);
            boolean b = adminService.saveOrUpdate(admin);
            if (b = true) {
                Map<String, Object> map = new HashMap<>();
                map.put("data", "true");
                map.put("code", 0);
                map.put("msg", "");
                return map;
            } else {
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false");
                map.put("code", 0);
                map.put("msg", "");
                return map;
            }
        }
    }


    //去注册界面
    @RequestMapping("/toregister")
    public String toregister() {
        return "reg";
    }


    //判断手机号是否注册
    @ResponseBody
    @RequestMapping("/isRegistered")
    public Object getCode2(String phone) {

        System.err.println(phone + "判断手机号是否注册");
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("phone", phone);
        User user = userService.getOne(wrapper);
        if (user == null) {
            //手机对应用户为空，可以注册
            Map<String, Object> map = new HashMap<>();
            map.put("data", "true");
            map.put("code", 0);
            map.put("msg", "");
            return map;
        } else {
            Map<String, Object> map = new HashMap<>();
            map.put("data", "false");
            map.put("code", 0);
            map.put("msg", "手机号对应用户已存在，不可以注册");
            return map;
        }
    }

    @ResponseBody
    @RequestMapping("/isRegistered2")
    public Object getCode3(String phone, String identity) {

        System.err.println("身份============" + identity);
        if ("用户".equals(identity)) {
            System.err.println(phone + "判断该用户手机号是否注册");
            QueryWrapper<User> wrapper = new QueryWrapper<>();
            wrapper.eq("phone", phone);
            User user = userService.getOne(wrapper);
            if (user == null) {
                Map<String, Object> map = new HashMap<>();
                map.put("data", "true");
                map.put("code", 0);
                map.put("msg", "用户！");
                return map;
            } else {
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false");
                map.put("code", 0);
                map.put("msg", "用户！");
                return map;
            }
        } else {
            System.err.println(phone + "判断该管理员手机号是否注册");
            QueryWrapper<Admin> wrapper = new QueryWrapper<>();
            wrapper.eq("phone", phone);
            Admin admin = adminService.getOne(wrapper);
            if (admin == null) {
                Map<String, Object> map = new HashMap<>();
                map.put("data", "true");
                map.put("code", 0);
                map.put("msg", "管理员！");
                return map;
            } else {
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false");
                map.put("code", 0);
                map.put("msg", "管理员！");
                return map;
            }
        }

    }

    //注册
    @ResponseBody
    @RequestMapping("/register")
    public Object register(User user, HttpSession session, String vercode) {
        //首先判断验证码输入是否正确
        String forNumber = (String) session.getAttribute("forNumber");
        if (forNumber.equals(vercode)) {
            //验证码正确，然后判断登录名是否存在
            String loginname = user.getLoginname();
            QueryWrapper<User> wrapper = new QueryWrapper<>();
            wrapper.eq("loginname", loginname);
            User user1 = userService.getOne(wrapper);
            if (user1 == null) {
                //用户名不存在，可以注册
                user.setCreatedate(new Date());
                String password = user.getPassword();
                //MD5加密
                String s = DigestUtils.md5DigestAsHex(password.getBytes());
                user.setPassword(s);
                boolean b = userService.saveOrUpdate(user);
                if (b = true) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("data", "true");
                    map.put("code", 0);
                    map.put("msg", "");
                    return map;
                } else {
                    Map<String, Object> map = new HashMap<>();
                    map.put("data", "false3");
                    map.put("code", 0);
                    map.put("msg", "未知错误，注册失败！");
                    return map;
                }

            } else {
                //登录名已经存在，不可注册
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false2");
                map.put("code", 0);
                map.put("msg", "登录名已经存在，不可注册");
                return map;
            }


        } else {
            //验证码错误
            Map<String, Object> map = new HashMap<>();
            map.put("data", "false");
            map.put("code", 0);
            map.put("msg", "验证码错误");
            return map;
        }


    }





/*
    public void getClientInfo(HttpServletRequest request, String loginname, HttpServletResponse response) throws UnsupportedEncodingException {
        String agent = request.getHeader("user-Agent");
        System.err.println(agent);

        //User Agent中文名为用户代理，简称 UA，它是一个特殊字符串头，使得服务器
        //能够识别客户使用的操作系统及版本、CPU 类型、浏览器及版本、
        //浏览器渲染引擎、浏览器语言、浏览器插件等
        UserAgent userAgent = UserAgent.parseUserAgentString(agent);
        //获取浏览器
        Browser browser = userAgent.getBrowser();
        System.err.println(browser.getName());
        //获取浏览器版本
        Version bv = userAgent.getBrowserVersion();
        //System.out.println(bv.getVersion());
        // 获取操作系统
        OperatingSystem os = userAgent.getOperatingSystem();
        //System.out.println(os.getName());

        String iphone = "";
        if (agent.contains("Windows NT")) {
            //pc型号获取方法实现
            String pc_regex = " \\((.*); ";
            Pattern pattern = Pattern.compile(pc_regex);
            Matcher matcher = pattern.matcher(agent);
            while (matcher.find()) {
                iphone = matcher.group(1);
            }
            agent = "PC端";
        } else {
            String type = "";
            if (agent.contains("iPhone") || agent.contains("iPod") || agent.contains("iPad")) {
                type = "ios";
            } else if (agent.contains("Android") || agent.contains("Linux")) {
                type = "apk";
            } else if (agent.indexOf("micromessenger") > 0) {
                type = "wx";
            }
            String iphone_regex = "\\((.*)\\) Apple";
            Pattern pattern = Pattern.compile(iphone_regex);
            Matcher matcher = pattern.matcher(agent);

            while (matcher.find()) {
                iphone = matcher.group(1);
            }
            agent = "移动端" + type;
        }

        System.out.println(iphone);
        System.out.println(agent);

        System.out.println("---------------------获取ip--------------------------");
        String ipAddress = null;
        if (request.getHeader("x-forwarded-for") == null) {
            ipAddress = request.getRemoteAddr();
        } else {
            if (request.getHeader("x-forwarded-for").length() > 15) {
                String[] aStr = request.getHeader("x-forwarded-for").split(",");
                ipAddress = aStr[0];
            } else {
                ipAddress = request.getHeader("x-forwarded-for");
            }
        }
        System.out.println(ipAddress);

        // 封装UservisitInf
        UservisitInf uservisitInf = new UservisitInf();
        uservisitInf.setLoginname(loginname);
        uservisitInf.setLoginTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        uservisitInf.setVisitIp(ipAddress);
        uservisitInf.setUserAddress("");
        uservisitInf.setUserFrom(agent);
        uservisitInf.setBrowser(browser.getName());
        uservisitInf.setOpsystem(os.getName());
        uservisitInf.setVersion(bv.getVersion());
        uservisitInf.setIphone(iphone);

        // 写入数据库
//        userService.save(uservisitInf);

        String s = null;
        try {
            s = new ObjectMapper().writeValueAsString(uservisitInf);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        // 写入redis
//        redisTemplate.opsForList().leftPush("users", s);
        //为实现登出时间放入用户访问对象
        request.getSession().setAttribute("USER_VISIT", uservisitInf);

 */





    public  void getClientInfo(HttpServletRequest request, String loginname){
        String agent =request.getHeader("User-Agent");
        System.out.println(agent);

        //User Agent中文名为用户代理，简称 UA，它是一个特殊字符串头，使得服务器
        //能够识别客户使用的操作系统及版本、CPU 类型、浏览器及版本、
        //浏览器渲染引擎、浏览器语言、浏览器插件等
        UserAgent userAgent = UserAgent.parseUserAgentString(agent);

        // 获取浏览器
        Browser browser = userAgent.getBrowser();
        //System.out.println(browser.getName());
        // 获取浏览器版本
        Version bv = userAgent.getBrowserVersion();
        //System.out.println(bv.getVersion());
        // 获取操作系统
        OperatingSystem os = userAgent.getOperatingSystem();
        //System.out.println(os.getName());

        String iphone = "";
        if (agent.contains("Windows NT")) {
            //pc型号获取方法实现
            String pc_regex = " \\((.*); ";
            Pattern pattern = Pattern.compile(pc_regex);
            Matcher matcher = pattern.matcher(agent);
            while (matcher.find()) {
                iphone = matcher.group(1);
            }
            agent = "PC端";
        } else {
            String type = "";
            if (agent.contains("iPhone") || agent.contains("iPod") || agent.contains("iPad")) {
                type = "ios";
            } else if (agent.contains("Android") || agent.contains("Linux")) {
                type = "apk";
            } else if (agent.indexOf("micromessenger") > 0) {
                type = "wx";
            }
            String iphone_regex = "\\((.*)\\) Apple";
            Pattern pattern = Pattern.compile(iphone_regex);
            Matcher matcher = pattern.matcher(agent);

            while (matcher.find()) {
                iphone = matcher.group(1);
            }
            agent = "移动端" + type;
        }

        System.out.println(iphone);
        System.out.println(agent);

        System.out.println("---------------------获取ip--------------------------");
        String ipAddress = null;
        if (request.getHeader("x-forwarded-for") == null) {
            ipAddress = request.getRemoteAddr();
        } else {
            if (request.getHeader("x-forwarded-for").length() > 15) {
                String[] aStr = request.getHeader("x-forwarded-for").split(",");
                ipAddress = aStr[0];
            } else {
                ipAddress = request.getHeader("x-forwarded-for");
            }
        }
        System.out.println(ipAddress);

        // 封装UservisitInf
        SysUservisit uservisitInf =new SysUservisit();
        uservisitInf.setLoginname(loginname);
        uservisitInf.setLoginTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        uservisitInf.setExitTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        uservisitInf.setVisitIp(ipAddress);
        uservisitInf.setUserAddress("");
        uservisitInf.setUserFrom(agent);
        uservisitInf.setBrowser(browser.getName());
        uservisitInf.setSystem(os.getName());
        uservisitInf.setVersion(bv.getVersion());
        uservisitInf.setIphone(iphone);

        // 写入数据库
        sysUservisitService.save(uservisitInf);
        String s = null;
        try {
            s = new ObjectMapper().writeValueAsString(uservisitInf);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        // 写入redis
         redisTemplate.opsForList().leftPush("users",s);

        // 写入到session
        request.getSession().setAttribute("USERV_ISIT",uservisitInf);
    }



}
