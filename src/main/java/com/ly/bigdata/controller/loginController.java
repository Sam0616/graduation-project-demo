package com.ly.bigdata.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ly.bigdata.po.Admin;
import com.ly.bigdata.po.User;
import com.ly.bigdata.service.AdminService;
import com.ly.bigdata.service.UserService;
import com.ly.bigdata.utils.NumberUtil;
import com.ly.bigdata.utils.SendMessageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class loginController {
    @Autowired
    private UserService userService;
    @Autowired
    private AdminService adminService;

    @ResponseBody
    @RequestMapping("/login")
    public Object login(String loginname, String password, String identity, String remember,
                        HttpSession session, HttpServletRequest request,
                        HttpServletResponse response) throws Exception {

        if (remember!=null){//勾选了记住密码
            Cookie pwd = new Cookie("pwd", password);
            Cookie name = new Cookie("name", loginname);
            pwd.setMaxAge(60*60*24*7);//记住密码一周
            name.setMaxAge(60*60*24*7);//记住密码一周
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
                //把当前用户放入session
                session.setAttribute("user_session", user);
                //将来在这录入登录浏览器的信息
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
                //将来在这录入登录浏览器的信息

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
    public Object getCode3(String phone,String identity) {

        System.err.println("身份============"+identity);
        if("用户".equals(identity)){
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
        }else {
            System.err.println(phone + "判断该管理员手机号是否注册");
            QueryWrapper<Admin> wrapper = new QueryWrapper<>();
            wrapper.eq("phone", phone);
            Admin admin = adminService.getOne(wrapper);
            if (admin==null){
                Map<String, Object> map = new HashMap<>();
                map.put("data", "true");
                map.put("code", 0);
                map.put("msg", "管理员！");
                return map;
            }else {
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
}
