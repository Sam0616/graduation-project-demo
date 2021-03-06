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

        if (remember != null) {//?????????????????????
            Cookie pwd = new Cookie("pwd", password);
            Cookie name = new Cookie("name", loginname);
            pwd.setMaxAge(60 * 60 * 24 * 7);//??????????????????
            name.setMaxAge(60 * 60 * 24 * 7);//??????????????????
            response.addCookie(pwd);
            response.addCookie(name);
        }

        if ("??????".equals(identity)) {
            QueryWrapper<User> wrapper = new QueryWrapper<>();
            //MD5??????
            String pwd = DigestUtils.md5DigestAsHex(password.getBytes());
            wrapper.eq("loginname", loginname).eq("password", pwd);
            User user = userService.getOne(wrapper);
            if (user != null) {

                //todo ?????????????????????????????????,?????????
                getClientInfo(request,loginname);
                //?????????????????????session
                session.setAttribute("user_session", user);
                Map<String, Object> map = new HashMap<>();
                map.put("data", "true");
                map.put("code", 0);
                map.put("msg", "??????");
                return map;
            } else {
                System.err.println("===????????????????????????===========================");
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false");
                map.put("code", 0);
                map.put("msg", "??????");
                return map;
            }

        } else {
            QueryWrapper<Admin> wrapper = new QueryWrapper<>();
            //MD5??????
            String pwd = DigestUtils.md5DigestAsHex(password.getBytes());
            wrapper.eq("loginname", loginname).eq("password", pwd);
            Admin admin = adminService.getOne(wrapper);
            if (admin != null) {
                //????????????????????????session
                session.setAttribute("admin_session", admin);

                Map<String, Object> map = new HashMap<>();
                map.put("data", "true");
                map.put("code", 0);
                map.put("msg", "?????????");
                return map;
            } else {
                System.err.println("===????????????????????????===========================");
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false");
                map.put("code", 0);
                map.put("msg", "?????????");
                return map;
            }
        }
    }


    //????????????
    @RequestMapping("/forget")
    public String repassword() {
        return "forget";
    }

    //?????????????????????
    @ResponseBody
    @RequestMapping("/getCode")
    public void getCode(String phone, HttpSession session) {
        System.err.println("???????????????????????????");
        String forNumber = NumberUtil.getForNumber();
        session.setAttribute("forNumber", forNumber);
        String[] datas = {forNumber, "1??????", "??????3"};
        SendMessageUtil.sendMsg(phone, datas);
    }

    //????????????
    @ResponseBody
    @RequestMapping("/findOutPwd")
    public Object findOutPwd(HttpSession session, String vercode, String phone, String identity) {
        //???????????????????????????
        if ("??????".equals(identity)) {
            //????????????????????????
            QueryWrapper<User> wrapper = new QueryWrapper<>();
            wrapper.eq("phone", phone);
            User user = userService.getOne(wrapper);
            if (user != null) {
                session.setAttribute("updPwdPeople", user);//??????????????????????????????
                session.setAttribute("PeopleIdentity", identity);//??????????????????????????????
                String forNumber = (String) session.getAttribute("forNumber");
                if (forNumber.equals(vercode)) {
                    //?????????????????????session???????????????
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
                    map.put("msg", "??????");
                    return map;
                }
            } else {
                //????????????????????????????????????
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false2");
                map.put("code", 0);
                map.put("msg", "????????????????????????????????????");
                return map;
            }


        } else {

            //???????????????????????????
            QueryWrapper<Admin> wrapper = new QueryWrapper<>();
            wrapper.eq("phone", phone);
            Admin admin = adminService.getOne(wrapper);
            if (admin != null) {
                session.setAttribute("updPwdPeople", admin);//??????????????????????????????
                session.setAttribute("PeopleIdentity", identity);//??????????????????????????????
                String forNumber = (String) session.getAttribute("forNumber");
                if (forNumber.equals(vercode)) {
                    //?????????????????????session???????????????
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
                    map.put("msg", "?????????");
                    return map;
                }
            } else {
                //???????????????????????????????????????
                System.err.println("???????????????????????????????????????");
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false3");
                map.put("code", 0);
                map.put("msg", "???????????????????????????????????????");
                return map;
            }
        }
    }

    //???????????????
    @ResponseBody
    @RequestMapping("/ResetPwd")
    public Object ResetPwd(HttpSession session, String password) {

        String peopleIdentity = (String) session.getAttribute("PeopleIdentity");
        if ("??????".equals(peopleIdentity)) {
            User user = (User) session.getAttribute("updPwdPeople");

            //MD5??????
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

            //MD5??????
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


    //???????????????
    @RequestMapping("/toregister")
    public String toregister() {
        return "reg";
    }


    //???????????????????????????
    @ResponseBody
    @RequestMapping("/isRegistered")
    public Object getCode2(String phone) {

        System.err.println(phone + "???????????????????????????");
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("phone", phone);
        User user = userService.getOne(wrapper);
        if (user == null) {
            //???????????????????????????????????????
            Map<String, Object> map = new HashMap<>();
            map.put("data", "true");
            map.put("code", 0);
            map.put("msg", "");
            return map;
        } else {
            Map<String, Object> map = new HashMap<>();
            map.put("data", "false");
            map.put("code", 0);
            map.put("msg", "????????????????????????????????????????????????");
            return map;
        }
    }

    @ResponseBody
    @RequestMapping("/isRegistered2")
    public Object getCode3(String phone, String identity) {

        System.err.println("??????============" + identity);
        if ("??????".equals(identity)) {
            System.err.println(phone + "????????????????????????????????????");
            QueryWrapper<User> wrapper = new QueryWrapper<>();
            wrapper.eq("phone", phone);
            User user = userService.getOne(wrapper);
            if (user == null) {
                Map<String, Object> map = new HashMap<>();
                map.put("data", "true");
                map.put("code", 0);
                map.put("msg", "?????????");
                return map;
            } else {
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false");
                map.put("code", 0);
                map.put("msg", "?????????");
                return map;
            }
        } else {
            System.err.println(phone + "???????????????????????????????????????");
            QueryWrapper<Admin> wrapper = new QueryWrapper<>();
            wrapper.eq("phone", phone);
            Admin admin = adminService.getOne(wrapper);
            if (admin == null) {
                Map<String, Object> map = new HashMap<>();
                map.put("data", "true");
                map.put("code", 0);
                map.put("msg", "????????????");
                return map;
            } else {
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false");
                map.put("code", 0);
                map.put("msg", "????????????");
                return map;
            }
        }

    }

    //??????
    @ResponseBody
    @RequestMapping("/register")
    public Object register(User user, HttpSession session, String vercode) {
        //???????????????????????????????????????
        String forNumber = (String) session.getAttribute("forNumber");
        if (forNumber.equals(vercode)) {
            //???????????????????????????????????????????????????
            String loginname = user.getLoginname();
            QueryWrapper<User> wrapper = new QueryWrapper<>();
            wrapper.eq("loginname", loginname);
            User user1 = userService.getOne(wrapper);
            if (user1 == null) {
                //?????????????????????????????????
                user.setCreatedate(new Date());
                String password = user.getPassword();
                //MD5??????
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
                    map.put("msg", "??????????????????????????????");
                    return map;
                }

            } else {
                //????????????????????????????????????
                Map<String, Object> map = new HashMap<>();
                map.put("data", "false2");
                map.put("code", 0);
                map.put("msg", "????????????????????????????????????");
                return map;
            }


        } else {
            //???????????????
            Map<String, Object> map = new HashMap<>();
            map.put("data", "false");
            map.put("code", 0);
            map.put("msg", "???????????????");
            return map;
        }


    }





/*
    public void getClientInfo(HttpServletRequest request, String loginname, HttpServletResponse response) throws UnsupportedEncodingException {
        String agent = request.getHeader("user-Agent");
        System.err.println(agent);

        //User Agent????????????????????????????????? UA???????????????????????????????????????????????????
        //???????????????????????????????????????????????????CPU ??????????????????????????????
        //????????????????????????????????????????????????????????????
        UserAgent userAgent = UserAgent.parseUserAgentString(agent);
        //???????????????
        Browser browser = userAgent.getBrowser();
        System.err.println(browser.getName());
        //?????????????????????
        Version bv = userAgent.getBrowserVersion();
        //System.out.println(bv.getVersion());
        // ??????????????????
        OperatingSystem os = userAgent.getOperatingSystem();
        //System.out.println(os.getName());

        String iphone = "";
        if (agent.contains("Windows NT")) {
            //pc????????????????????????
            String pc_regex = " \\((.*); ";
            Pattern pattern = Pattern.compile(pc_regex);
            Matcher matcher = pattern.matcher(agent);
            while (matcher.find()) {
                iphone = matcher.group(1);
            }
            agent = "PC???";
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
            agent = "?????????" + type;
        }

        System.out.println(iphone);
        System.out.println(agent);

        System.out.println("---------------------??????ip--------------------------");
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

        // ??????UservisitInf
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

        // ???????????????
//        userService.save(uservisitInf);

        String s = null;
        try {
            s = new ObjectMapper().writeValueAsString(uservisitInf);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        // ??????redis
//        redisTemplate.opsForList().leftPush("users", s);
        //?????????????????????????????????????????????
        request.getSession().setAttribute("USER_VISIT", uservisitInf);

 */





    public  void getClientInfo(HttpServletRequest request, String loginname){
        String agent =request.getHeader("User-Agent");
        System.out.println(agent);

        //User Agent????????????????????????????????? UA???????????????????????????????????????????????????
        //???????????????????????????????????????????????????CPU ??????????????????????????????
        //????????????????????????????????????????????????????????????
        UserAgent userAgent = UserAgent.parseUserAgentString(agent);

        // ???????????????
        Browser browser = userAgent.getBrowser();
        //System.out.println(browser.getName());
        // ?????????????????????
        Version bv = userAgent.getBrowserVersion();
        //System.out.println(bv.getVersion());
        // ??????????????????
        OperatingSystem os = userAgent.getOperatingSystem();
        //System.out.println(os.getName());

        String iphone = "";
        if (agent.contains("Windows NT")) {
            //pc????????????????????????
            String pc_regex = " \\((.*); ";
            Pattern pattern = Pattern.compile(pc_regex);
            Matcher matcher = pattern.matcher(agent);
            while (matcher.find()) {
                iphone = matcher.group(1);
            }
            agent = "PC???";
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
            agent = "?????????" + type;
        }

        System.out.println(iphone);
        System.out.println(agent);

        System.out.println("---------------------??????ip--------------------------");
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

        // ??????UservisitInf
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

        // ???????????????
        sysUservisitService.save(uservisitInf);
        String s = null;
        try {
            s = new ObjectMapper().writeValueAsString(uservisitInf);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        // ??????redis
         redisTemplate.opsForList().leftPush("users",s);

        // ?????????session
        request.getSession().setAttribute("USERV_ISIT",uservisitInf);
    }



}
