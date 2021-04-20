package com.ly.bigdata.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Article;
import com.ly.bigdata.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-17
 */
@Controller
@RequestMapping("/article")
public class ArticleController {
    @Autowired
    private ArticleService articleService;


    @RequestMapping("/toList")

    public String tolist(Model model,
                         @RequestParam(value = "pageNo", defaultValue = "1")
                                 Integer pageNum,
                         @RequestParam(value = "pageSize", defaultValue = "5")
                                 Integer pageSize,
                         @RequestParam(value = "content", required = false)
                                 String content) {

        Page<Article> page = new Page<>(pageNum, pageSize);

        articleService.getArticles(page, content);
        model.addAttribute("list", page.getRecords());
        model.addAttribute("pageNo", page.getCurrent());//当前页
        model.addAttribute("pageSize", page.getSize());////每页记录数
        model.addAttribute("count", page.getTotal());//总记录数
        return "admin/article/list";
    }


    @RequestMapping("/toUpd")
    public String toUpd(Integer id, Model model) {
        //查数据
        Article article = articleService.getById(id);
        model.addAttribute("article", article);
        return "admin/article/edit";
    }

    @ResponseBody
    @RequestMapping("/upd")
    public void upd(Article article) {
        articleService.saveOrUpdate(article);
    }


    @ResponseBody
    @RequestMapping("/del")
    public String del(Integer id) {
        boolean b = articleService.removeById(id);
        if (b == true) {
            return "true";
        } else {
            return "false";
        }
    }


    @RequestMapping("/toAdd")
    public String toadd(Model model) {
        return "admin/article/add";
    }


    @RequestMapping("/add")
    public String add(Article article) {
        Date now = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String cteatetime = format.format(now);
        article.setCreatetime(cteatetime);
        //这里先写死，写完登录后再从session中拿
        article.setAdminId(12);
        articleService.saveOrUpdate(article);
        return "redirect:/article/toList";
    }

}

