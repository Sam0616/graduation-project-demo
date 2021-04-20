package com.ly.bigdata.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Comment;
import com.ly.bigdata.po.Pet;
import com.ly.bigdata.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-17
 */
@Controller
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;
    @RequestMapping("/toList")
    public String tolist() {
        return "admin/comment/list";
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

        Page<Comment> page = new Page<>(pageNum, pageSize);

        commentService.getComments(page, content);

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
        commentService.removeById(id);
    }

    @ResponseBody
    @RequestMapping("/delBatches")
    public void delBatches(@RequestParam(value = "ids[]") Integer[] ids) {
        commentService.removeByIds(Arrays.asList(ids));
    }
}

