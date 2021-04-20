package com.ly.bigdata.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Admin;
import com.ly.bigdata.po.User;
import com.ly.bigdata.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-12
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/toList")
    public String tolist() {

        return "admin/user/list";
    }

    @ResponseBody
    @RequestMapping("/list")
    public Object getList(
            @RequestParam(value = "page", defaultValue = "1")
                    Integer pageNum,
            @RequestParam(value = "limit", defaultValue = "6")
                    Integer pageSize,
            @RequestParam(value = "content", required = false)
                    String content) {

        Page<User> page = new Page<>(pageNum, pageSize);

        if (content != null && !"".equals(content)) {
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            queryWrapper.like("loginname", content).or()
                    .like("realname", content).or()
                    .like("email", content).or()
                    .like("address", content).or()
                    .like("phone", content);

            userService.page(page, queryWrapper);
        } else {
            userService.page(page, null);
        }

        Map<String, Object> map = new HashMap<>();

        map.put("data", page.getRecords());
        map.put("count", page.getTotal());
        map.put("code", 0);
        map.put("msg", "");
        return map;
    }

    @ResponseBody
    @RequestMapping("/del")
    public void del(Integer id) {
        userService.removeById(id);
    }

    @ResponseBody
    @RequestMapping("/delBatches")
    public void delBatches(@RequestParam(value = "ids[]") Integer[] ids) {
        userService.removeByIds(Arrays.asList(ids));
    }

    @RequestMapping("/toUpd")
    public String toUpd(Integer id, Model model) {
        //查数据
        User user = userService.getById(id);
        Date birthday = user.getBirthday();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String s = sdf.format(birthday);
        model.addAttribute("birthday", s);
        model.addAttribute("user", user);
        return "admin/user/edit";
    }

    @ResponseBody
    @RequestMapping("/upd")
    public void upd(User user,String birthdays) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = format.parse(birthdays);
        user.setBirthday(date);
        userService.saveOrUpdate(user);
    }


    @RequestMapping("/toAdd")
    public String toadd() {
        // System.err.println("进入add");
        return "admin/user/add";
    }

    @RequestMapping("/add")
    public String add(User user, String birthdays) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = format.parse(birthdays);
        user.setBirthday(date);
        user.setCreatedate(new Date());
        String password = user.getPassword();
        //MD5加密
        String s = DigestUtils.md5DigestAsHex(password.getBytes());
        user.setPassword(s);
        userService.saveOrUpdate(user);
        return "redirect:/user/toList";
    }

}

