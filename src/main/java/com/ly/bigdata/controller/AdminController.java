package com.ly.bigdata.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Admin;
import com.ly.bigdata.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.text.AttributedString;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-11
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService adminService;

    @ResponseBody
    @RequestMapping("/list")
    public Object getList(
            @RequestParam(value = "page", defaultValue = "1")
                    Integer pageNum,
            @RequestParam(value = "limit", defaultValue = "6")
                    Integer pageSize,
            @RequestParam(value = "content", required = false)
                    String content) {

        Page<Admin> page = new Page<>(pageNum, pageSize);

        if (content != null && !"".equals(content)) {
            QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
            queryWrapper.like("loginname", content).or()
                    .like("realname", content).or()
                    .like("email", content).or()
                    .like("phone", content);

            adminService.page(page, queryWrapper);
        } else {
            adminService.page(page, null);
        }

        Map<String, Object> map = new HashMap<>();

        map.put("data", page.getRecords());
        map.put("count", page.getTotal());
        map.put("code", 0);
        map.put("msg", "");
        return map;
    }


    @RequestMapping("/tolist")
    public String tolist(HttpSession session) {
        Admin admin_session = (Admin) session.getAttribute("admin_session");
        if (admin_session.getRole()==1){
            //管理员
            return "admin/admin/list";
        }else {
            return "admin/admin/list2";
        }
    }

    @ResponseBody
    @RequestMapping("/del")
    public void del(Integer id) {
        adminService.removeById(id);
    }

    @ResponseBody
    @RequestMapping("/delBatches")
    public void delBatches(@RequestParam(value = "ids[]") Integer[] ids) {
        adminService.removeByIds(Arrays.asList(ids));
    }


    @RequestMapping("/toUpd")
    public String toUpd(Integer id, Model model) {
        //查数据
        Admin admin = adminService.getById(id);
        Date birthday = admin.getBirthday();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String s = sdf.format(birthday);
        model.addAttribute("birthday", s);
        model.addAttribute("admin", admin);
        return "admin/admin/edit";
    }

    @ResponseBody
    @RequestMapping("/upd")
    public void upd(Admin admin, String birthdays) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = format.parse(birthdays);
        admin.setBirthday(date);
        System.err.println(admin);
        adminService.saveOrUpdate(admin);
    }

    @RequestMapping("/toAdd")
    public String toadd() {
        // System.err.println("进入add");
        return "admin/admin/add";
    }

    @RequestMapping("/add")
    public String add(Admin admin, String birthdays) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = format.parse(birthdays);
        admin.setBirthday(date);
        admin.setCreatedate(new Date());
        String password = admin.getPassword();
        //MD5加密
        String s = DigestUtils.md5DigestAsHex(password.getBytes());
        admin.setPassword(s);
        adminService.saveOrUpdate(admin);
        return "redirect:/admin/tolist";
    }


    @RequestMapping("/toupdPassword")
    public String toupdPassword(){
        return "admin/editPassword";
    }

    @ResponseBody
    @RequestMapping("/rePassword")
    public Object rePassword(String oldpassword, String password,HttpSession session){

        Admin admin_session = (Admin) session.getAttribute("admin_session");
        String passwordSession = admin_session.getPassword();
        String s = DigestUtils.md5DigestAsHex(oldpassword.getBytes());
        if (!s.equals(passwordSession)){//旧密码输入错误
            HashMap<Object, Object> map = new HashMap<>();
            map.put("flag",0);
            return map;
        }else {
            //修改密码
            String s2 = DigestUtils.md5DigestAsHex(password.getBytes());
            admin_session.setPassword(s2);
            boolean b = adminService.saveOrUpdate(admin_session);
            if (b==true){
                HashMap<Object, Object> map = new HashMap<>();
                map.put("flag",1);
                return map;
            }else {
                HashMap<Object, Object> map = new HashMap<>();
                map.put("flag",2);
                return map;
            }
        }
    }

    @RequestMapping("/toPersonPage")
    public String toPersonPage(){
        return "admin/personPage";
    }

}

