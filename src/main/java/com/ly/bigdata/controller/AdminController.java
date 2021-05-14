package com.ly.bigdata.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Admin;
import com.ly.bigdata.po.Pet;
import com.ly.bigdata.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.crypto.interfaces.PBEKey;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
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
        if (admin_session.getRole() == 1) {
            //管理员
            return "admin/admin/list";
        } else {
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
    public String toupdPassword() {
        return "admin/editPassword";
    }

    @ResponseBody
    @RequestMapping("/rePassword")
    public Object rePassword(String oldpassword, String password, HttpSession session) {

        Admin admin_session = (Admin) session.getAttribute("admin_session");
        String passwordSession = admin_session.getPassword();
        String s = DigestUtils.md5DigestAsHex(oldpassword.getBytes());
        if (!s.equals(passwordSession)) {//旧密码输入错误
            HashMap<Object, Object> map = new HashMap<>();
            map.put("flag", 0);
            return map;
        } else {
            //修改密码
            String s2 = DigestUtils.md5DigestAsHex(password.getBytes());
            admin_session.setPassword(s2);
            boolean b = adminService.saveOrUpdate(admin_session);
            if (b == true) {
                HashMap<Object, Object> map = new HashMap<>();
                map.put("flag", 1);
                return map;
            } else {
                HashMap<Object, Object> map = new HashMap<>();
                map.put("flag", 2);
                return map;
            }
        }
    }

    @RequestMapping("/toPersonPage")
    public String toPersonPage(Model model, HttpSession session) {
        Admin admin_session = (Admin) session.getAttribute("admin_session");
        Integer id = admin_session.getId();
        Admin byId = adminService.getById(id);
        model.addAttribute("admin", byId);
        Date birthday = byId.getBirthday();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String s = sdf.format(birthday);
        model.addAttribute("birthday", s);
        return "admin/personPage";
    }


    @ResponseBody
    @RequestMapping("/personInfo")
    public Object personInfo(Admin admin, String birthdays) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = format.parse(birthdays);
        admin.setBirthday(date);
        boolean b = adminService.saveOrUpdate(admin);
        if (b == true) {
            HashMap<Object, Object> map = new HashMap<>();
            map.put("flag",true);
            map.put("adminName",admin.getRealname());
            return map;
        } else {
            HashMap<Object, Object> map = new HashMap<>();
            map.put("flag",false);
            map.put("adminName",admin.getRealname());
            return map;
        }
    }

    @RequestMapping("/touploadIcon")
    public String touploadIcon(Model model, HttpSession session) {
        Admin admin_session = (Admin) session.getAttribute("admin_session");
        Integer id = admin_session.getId();
        Admin byId = adminService.getById(id);
        model.addAttribute("admin", byId);
        return "admin/uploadIcon";
    }


    @ResponseBody
    @RequestMapping("/updImg2")
    public Object updImg2(MultipartFile file, HttpServletRequest request, HttpSession session) throws IOException {

/*      String path=System.getProperty("user.dir");
        String filePath=path+"/main/java/resources/static/img";*/

        // 找上传文件的位置
        String realPath = request.getServletContext().getRealPath("/WEB-INF/files");
        System.err.println("~~~realPath~~~" + realPath);
        // 上传文件名称
        String originalFilename = file.getOriginalFilename();
        System.err.println("~~~originalFilename~~~" + originalFilename);

        // 上传文件，复制文件
        File file1 = new File(realPath, originalFilename);
        //把file1这个文件路径所指向的文件上传到对应的目录下。
        file.transferTo(file1);

        String imgpath = "/img/" + originalFilename;
        //操作数据库
        Admin admin_session = (Admin) session.getAttribute("admin_session");
        if (admin_session == null) {
            Map<String, Object> map = new HashMap<>();
            map.put("data", imgpath);
            map.put("code", 0);
            map.put("msg", "未登录");
            return map;
        } else {
            Admin admin = admin_session.setImgpath(imgpath);
            boolean b = adminService.saveOrUpdate(admin);
            if (b == true) {
                Map<String, Object> map = new HashMap<>();
                map.put("data", imgpath);
                map.put("code", 0);
                map.put("msg", true);
                return map;
            }else {
                Map<String, Object> map = new HashMap<>();
                map.put("data", imgpath);
                map.put("code", 0);
                map.put("msg", true);
                return map;
            }
        }
    }
}

