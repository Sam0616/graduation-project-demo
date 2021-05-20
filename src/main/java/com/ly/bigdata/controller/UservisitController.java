package com.ly.bigdata.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.SysUservisit;
import com.ly.bigdata.service.SysUservisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-05-20
 */
@Controller
@RequestMapping("/uservisit")
public class UservisitController {

    @Autowired
    private SysUservisitService uservisitService;

    @ResponseBody
    @RequestMapping("list")
    public Map<String,Object> toList(@RequestParam(value = "page",defaultValue = "1") Integer pageNo,
                                     @RequestParam(value = "limit",defaultValue = "10") Integer pageSize,
                                     @RequestParam(value = "content",required = false) String content,
                                     Model model){
        Map<String,Object> map = new HashMap<>();
        Page<SysUservisit> page = new Page<SysUservisit>(pageNo,pageSize);

        if(content == null || content.equals("")){
            uservisitService.page(page,new QueryWrapper<SysUservisit>().orderByDesc("id"));
        }else {
            QueryWrapper<SysUservisit> wrapper = new QueryWrapper<SysUservisit>();
            wrapper.like("loginname","%"+content+"%")
                    .or().like("visit_ip","%"+content+"%");

            uservisitService.page(page,wrapper);
            model.addAttribute("content",content);
        }

        map.put("code",0);
        map.put("msg","");
        map.put("count",page.getTotal());
        map.put("data",page.getRecords());


        return map;
    }



    @RequestMapping("/listpage")
    public String toList(){
        return "admin/user/visitlist";
    }


    @ResponseBody
    @RequestMapping("/delete")
    public String delete(Integer id){

        System.out.println(id);
        uservisitService.removeById(id);

        return "true";
    }

    @ResponseBody
    @RequestMapping("/deleteIds")
    public String deleteIds(@RequestParam(value = "ids[]") Integer[] ids){
        System.out.println(Arrays.toString(ids));

        uservisitService.removeByIds(Arrays.asList(ids));
        return "true";
    }

}

