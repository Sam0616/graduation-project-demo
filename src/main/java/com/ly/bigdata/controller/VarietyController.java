package com.ly.bigdata.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Category;
import com.ly.bigdata.po.Variety;
import com.ly.bigdata.service.CategoryService;
import com.ly.bigdata.service.VarietyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
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
@RequestMapping("/variety")
public class VarietyController {

    @Autowired
    private VarietyService varietyService;
    @Autowired
    private CategoryService categoryService;

    @RequestMapping("/toList")
    public String tolist() {
        return "admin/variety/list";
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

        Page<Variety> page = new Page<>(pageNum, pageSize);

        varietyService.getVarieties(page, content);

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
        varietyService.removeById(id);
    }

    @ResponseBody
    @RequestMapping("/delBatches")
    public void delBatches(@RequestParam(value = "ids[]") Integer[] ids) {
        varietyService.removeByIds(Arrays.asList(ids));
    }


    @RequestMapping("/toUpd")
    public String toUpd(Integer id, Model model) {
        //查数据
        Variety variety = varietyService.getById(id);
        Category category = categoryService.getById(variety.getCategoryId());
        String categoryName = category.getName();
        variety.setCname(categoryName);
        model.addAttribute("variety", variety);
        return "admin/variety/edit";
    }

    @ResponseBody
    @RequestMapping("/upd")
    public void upd(Variety variety) throws ParseException {
        System.err.println(variety);
        varietyService.saveOrUpdate(variety);
    }

    @RequestMapping("/toAdd")
    public String toadd(Model model) {
        List<Category> list = categoryService.list();
        model.addAttribute("categoryList", list);
        return "admin/variety/add";
    }

    //varietyService.getOne(wrapper,false);//加上false,多条符合时，只拿第一条，不加的话，报错
    //添加写在这了
    @ResponseBody
    @RequestMapping("/checkVariety")
    public Object checkVariety(Variety variety) {
        String name = variety.getName();
        QueryWrapper<Variety> wrapper = new QueryWrapper<>();
        wrapper.eq("name", name);
        List<Variety> list = varietyService.list(wrapper);
        if (list.size() <= 0) {
            //说明没有重复的品种，放行
            varietyService.saveOrUpdate(variety);
            return variety;
        } else {
            return "false";
        }
    }
}

