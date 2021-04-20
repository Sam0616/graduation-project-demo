package com.ly.bigdata.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Admin;
import com.ly.bigdata.po.Category;
import com.ly.bigdata.po.User;
import com.ly.bigdata.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
 * @since 2021-04-14
 */
@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @RequestMapping("/toList")
    public String tolist() {
        return "admin/category/list";
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

        Page<Category> page = new Page<>(pageNum, pageSize);

        if (content != null && !"".equals(content)) {
            QueryWrapper<Category> queryWrapper = new QueryWrapper<>();
            queryWrapper.like("name", content);
            categoryService.page(page, queryWrapper);
        } else {
            categoryService.page(page, null);
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
        categoryService.removeById(id);
    }

    @ResponseBody
    @RequestMapping("/delBatches")
    public void delBatches(@RequestParam(value = "ids[]") Integer[] ids) {
        categoryService.removeByIds(Arrays.asList(ids));
    }


    @RequestMapping("/toUpd")
    public String toUpd(Integer id, Model model) {
        //查数据
        Category category = categoryService.getById(id);
        model.addAttribute("category", category);
        return "admin/category/edit";
    }

    @ResponseBody
    @RequestMapping("/upd")
    public void upd(Category category) throws ParseException {
        System.err.println(category);
        categoryService.saveOrUpdate(category);
    }

    @RequestMapping("/toAdd")
    public String toadd() {
        return "admin/category/add";
    }

    @ResponseBody
    @RequestMapping("/add")
    public void add(Category category) throws ParseException {
        categoryService.saveOrUpdate(category);
    }

}

