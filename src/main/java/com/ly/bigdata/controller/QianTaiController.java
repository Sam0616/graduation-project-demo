package com.ly.bigdata.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.*;
import com.ly.bigdata.service.AdoptService;
import com.ly.bigdata.service.ArticleService;
import com.ly.bigdata.service.CommentService;
import com.ly.bigdata.service.PetService;
import com.sun.mail.imap.protocol.ID;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class QianTaiController {
    @Autowired
    private PetService petService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private AdoptService adoptService;
    @Autowired
    private ArticleService articleService;


    @RequestMapping("/qiantaiIndex")
    @ResponseBody
    public Object getList(//前台显示策略：已经被领养的不再显示
                          @RequestParam(value = "page", defaultValue = "1")
                                  Integer pageNum,
                          @RequestParam(value = "limit", defaultValue = "5")
                                  Integer pageSize,
                          @RequestParam(value = "content", required = false)
                                  String content) {

        Page<Pet> page = new Page<>(pageNum, pageSize);

        petService.getPetsFront(page, content);


        Map<String, Object> map = new HashMap<>();

        map.put("list", page.getRecords());
        map.put("count", page.getTotal());
        map.put("limit", page.getSize());
        map.put("page", page.getCurrent());
        map.put("pages", page.getPages());
        map.put("nextPage", page.hasNext() ? page.getCurrent() + 1 : page.getCurrent());
        map.put("prePage", page.hasPrevious() ? page.getCurrent() - 1 : page.getCurrent());
        return map;
    }

    @RequestMapping("/toDisplaypet")
    public String toDisplaypet(Model model, String petid) {
        QueryWrapper<Pet> wrapper = new QueryWrapper<>();
        wrapper.eq("id", petid);
        Pet one = petService.getOne(wrapper);
        //获取该动物的评论
        String petname = one.getPetname();
//        System.err.println(petname);
        Page<Comment> page = new Page<>(1, 10000);
        commentService.getComments(page, petname);
//        System.err.println(page.getRecords());
        model.addAttribute("comments", page.getRecords());
        model.addAttribute("pet", one);
        return "user/displayPet";
    }

    @RequestMapping("/addComment")
    public String addComment(String id, Model model) {
        model.addAttribute("id", id);
        return "user/addComment";
    }

    @ResponseBody
    @RequestMapping("/addCommentIng")
    public void addCommentIng(String content, Integer petId, HttpSession session) {
        User user = (User) session.getAttribute("user_session");
        Integer userId = user.getId();
        Date now = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String format1 = format.format(now);
        Comment comment = new Comment();
        comment.setContent(content);
        comment.setPetId(petId);
        comment.setUserId(userId);
        comment.setCreatetime(format1);
        commentService.saveOrUpdate(comment);
    }

    @ResponseBody
    @RequestMapping("/checkComplete")
    //检验是否完善了个人信息,然后检测是否已经申请领养过该宠物
    public Object checkComplete(HttpSession session, String petId) {
        User user = (User) session.getAttribute("user_session");
        Date birthday = user.getBirthday();
        if (birthday == null) {
            //未完善信息，不让领养
            HashMap<Object, Object> map = new HashMap<>();
            map.put("msg", 0);
            return map;
        } else {
            //信息完善，让领养,然后检测是否已经申请领养过该宠物
            Integer userId = user.getId();
            QueryWrapper<Adopt> wrapper = new QueryWrapper<>();
            wrapper.eq("user_id", userId).eq("pet_id", petId);
            Adopt adopt = adoptService.getOne(wrapper, false);
            if (adopt != null) {//这兄弟已经申请领养过该宠物了
                HashMap<Object, Object> map = new HashMap<>();
                map.put("msg", 1);
                map.put("experience", 1);
                return map;
            } else {
                HashMap<Object, Object> map = new HashMap<>();
                map.put("msg", 1);
                map.put("experience", 0);
                return map;
            }
        }
    }

    @RequestMapping("/toAdopt")
    public String toAdopt(String id, Model model) {
        model.addAttribute("id", id);
        return "user/addAdopt";
    }

    @ResponseBody
    @RequestMapping("/addAdopt")
    public Object addAdopt(Integer petId, String message, HttpSession session) {

        Date now = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String createtime = format.format(now);
        User user = (User) session.getAttribute("user_session");
        Integer userId = user.getId();
        QueryWrapper<Adopt> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id", userId).eq("pet_id", petId);
        Adopt adopt2 = adoptService.getOne(wrapper, false);
        Adopt adopt = new Adopt();

        if (adopt2 != null) {
            Integer id = adopt2.getId();
            adopt.setId(id);
            adopt.setCreatetime(createtime);
            adopt.setPetId(petId);
            adopt.setUserId(userId);
            adopt.setMessage(message);
        } else {
            adopt.setCreatetime(createtime);
            adopt.setPetId(petId);
            adopt.setUserId(userId);
            adopt.setMessage(message);
        }

        boolean b = adoptService.saveOrUpdate(adopt);
        if (b == true) {
            //将该宠物的申请状态置为申请中
            Pet pet = petService.getById(petId);
            pet.setStatus(1);
            petService.saveOrUpdate(pet);
            HashMap<Object, Object> map = new HashMap<>();
            map.put("msg", 1);
            return map;
        } else {
            HashMap<Object, Object> map = new HashMap<>();
            map.put("msg", 0);
            return map;
        }
    }


    @RequestMapping("/toArticleList")
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
        model.addAttribute("pageSize", page.getSize());//每页记录数
        model.addAttribute("count", page.getTotal());//总记录数
        return "user/information";
    }

    @RequestMapping("/toImages")
    public String toImages() {
        return "user/images";
    }

    @RequestMapping("/petList")
    public String petList() {
        return "user/petList";
    }

    @RequestMapping("/toContent")
    public String toContent(Integer id, Model model) {
        //查数据
        Article article = articleService.getById(id);
        model.addAttribute("article", article);
        return "user/articleContent";
    }


    //返回搜索后文章列表
    @RequestMapping("/toList2")
    public String tolist2(Model model,
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
        return "user/information";
    }

    @RequestMapping("/personalAdopt")
    public String personalAdopt() {
        return "user/personalAdopt";
    }


    //个人领养界面的index
    @RequestMapping("/qiantaiIndex2")
    @ResponseBody
    public Object getList2(//前台显示策略：已经被领养的不再显示
                           @RequestParam(value = "page", defaultValue = "1")
                                   Integer pageNum,
                           HttpSession session,
                           @RequestParam(value = "limit", defaultValue = "5")
                                   Integer pageSize,
                           @RequestParam(value = "content", required = false)
                                   String content) {

        Page<Pet> page = new Page<>(pageNum, pageSize);

        petService.getPetspersonal(page, content);


        Map<String, Object> map = new HashMap<>();

        map.put("list", page.getRecords());
        map.put("count", page.getTotal());
        map.put("limit", page.getSize());
        map.put("page", page.getCurrent());
        map.put("pages", page.getPages());
        map.put("nextPage", page.hasNext() ? page.getCurrent() + 1 : page.getCurrent());
        map.put("prePage", page.hasPrevious() ? page.getCurrent() - 1 : page.getCurrent());
        return map;
    }
}
