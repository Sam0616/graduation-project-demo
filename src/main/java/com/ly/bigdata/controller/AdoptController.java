package com.ly.bigdata.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Adopt;
import com.ly.bigdata.po.Category;
import com.ly.bigdata.po.Variety;
import com.ly.bigdata.po.VerifyStatus;
import com.ly.bigdata.service.AdminService;
import com.ly.bigdata.service.AdoptService;
import com.ly.bigdata.service.VerifyStatusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.text.ParseException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-16
 */
@Controller
@RequestMapping("/adopt")
public class AdoptController {

    @Autowired
    private AdoptService adoptService;
    @Autowired
    private VerifyStatusService verifyStatusService;
    @RequestMapping("/toList")
    public String tolist() {
        return "admin/adopt/list";
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


        Page<Adopt> page = new Page<>(pageNum, pageSize);

        adoptService.getAdopts(page, content);

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
        adoptService.removeById(id);
    }

    @ResponseBody
    @RequestMapping("/delBatches")
    public void delBatches(@RequestParam(value = "ids[]") Integer[] ids) {
        adoptService.removeByIds(Arrays.asList(ids));
    }


    @RequestMapping("/toUpd")
    public String toUpd(Integer id, Model model) {
        //查数据

        List<VerifyStatus> list = verifyStatusService.list();
        model.addAttribute("StatusList",list);

        Adopt adopt = adoptService.getById(id);
        Integer verifyStatusId = adopt.getVerifyStatusId();
        VerifyStatus verifyStatus = verifyStatusService.getById(verifyStatusId);
        String type = verifyStatus.getType();
        adopt.setVtype(type);
        model.addAttribute("adopt", adopt);

        return "admin/adopt/edit";
    }

    @ResponseBody
    @RequestMapping("/upd")
    public void upd(Adopt adopt) throws ParseException {
        //System.err.println(adopt);
        adoptService.saveOrUpdate(adopt);
    }

}

