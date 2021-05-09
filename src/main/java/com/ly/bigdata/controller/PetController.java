package com.ly.bigdata.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Category;
import com.ly.bigdata.po.Pet;
import com.ly.bigdata.po.Variety;
import com.ly.bigdata.service.CategoryService;
import com.ly.bigdata.service.PetService;
import com.ly.bigdata.service.VarietyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-14
 */
@Controller
@RequestMapping("/pet")
public class PetController {

    @Autowired
    private PetService petService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private VarietyService varietyService;

    @RequestMapping("/toList")
    public String tolist() {
        return "admin/pet/list";
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

        Page<Pet> page = new Page<>(pageNum, pageSize);

        petService.getPets(page, content);

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
        petService.removeById(id);
    }

    @ResponseBody
    @RequestMapping("/delBatches")
    public void delBatches(@RequestParam(value = "ids[]") Integer[] ids) {
        petService.removeByIds(Arrays.asList(ids));
    }


    @RequestMapping("/toUpd")
    public String toUpd(Integer id, Model model) {
        //查数据
        Pet pet = petService.getById(id);
        Integer categoryId = pet.getCategoryId();
        Category category = categoryService.getById(categoryId);
        String categoryName = category.getName();//类别名

        List<Category> list = categoryService.list();
        model.addAttribute("categoryList", list);

        Integer varietyId = pet.getVarietyId();
        Variety variety = varietyService.getById(varietyId);
        String varietyName = variety.getName();//品种名

        QueryWrapper<Variety> wrapper = new QueryWrapper<>();
        wrapper.eq("category_id", categoryId);
        List<Variety> list1 = varietyService.list(wrapper);
        model.addAttribute("varietyList", list1);

        pet.setCname(categoryName);
        pet.setVname(varietyName);
        model.addAttribute("pet", pet);
        return "admin/pet/edit";
    }


    @ResponseBody
    @RequestMapping("/upd")
    public void upd(Pet pet){
        String imgpath = pet.getImgpath();
        if (imgpath==null||"".equals(imgpath)){
            //这种只更新其他属性，不更新宠物图片的操作，需要查回原来的图片路径，再设置回去，不然修改后图片会丢失
            Integer id = pet.getId();
            Pet pet2 = petService.getById(id);
            String imgpath1 = pet2.getImgpath();
            pet.setImgpath(imgpath1);//查回原来的图片路径，再设置回去，就不会出现图片丢失的bug了
        }
        petService.saveOrUpdate(pet);
    }


    @ResponseBody
    @RequestMapping("/updImg")
    public Object updImg(Pet pet, MultipartFile file, HttpServletRequest request) throws IOException {

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
        Map<String, Object> map = new HashMap<>();
        map.put("data", imgpath);
        map.put("code", 0);
        map.put("msg", "");
        return map;
    }


    @RequestMapping("/toAdd")
    public String toadd(Model model) {
        List<Category> list = categoryService.list();
        model.addAttribute("categoryList", list);
        return "admin/pet/add";
    }


    @RequestMapping("/add")
    public String add(Pet pet) {
        Date now = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String cteatetime = format.format(now);
        pet.setCreatetime(cteatetime);

        petService.saveOrUpdate(pet);
        return "redirect:/pet/toList";
    }


    //二级联动//得到品种
    @ResponseBody
    @RequestMapping("/getvariety")
    public Object erjiliandong(String id) {
        QueryWrapper<Variety> wrapper = new QueryWrapper<>();
        wrapper.eq("category_id", id);
        List<Variety> list = varietyService.list(wrapper);//筛选后的品种
        return list;
    }


}

