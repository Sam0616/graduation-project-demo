package com.ly.bigdata.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.*;
import com.ly.bigdata.service.*;
import com.sun.mail.imap.protocol.ID;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

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
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private UserService userService;


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
    public String toAdopt(String id, Model model, HttpSession session) {
        model.addAttribute("id", id);

        User user = (User) session.getAttribute("user_session");
        Integer userId = user.getId();
        QueryWrapper<Adopt> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id", userId).eq("pet_id", id);
        Adopt adopt2 = adoptService.getOne(wrapper, false);
        model.addAttribute("adopt", adopt2);
        return "user/addAdopt";
    }

    @RequestMapping("/toAdopt2")
    public String toAdopt2(String id, Model model, HttpSession session) {
        model.addAttribute("id", id);

        User user = (User) session.getAttribute("user_session");
        Integer userId = user.getId();
        QueryWrapper<Adopt> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id", userId).eq("pet_id", id);
        Adopt adopt2 = adoptService.getOne(wrapper, false);
        model.addAttribute("adopt", adopt2);
        return "user/updAdopt";
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

    @RequestMapping("/personalAdopt")
    public String personalList() {
        return "user/personalAdopt";
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


    //个人领养界面的index
    @RequestMapping("/qiantaiIndex2")
    @ResponseBody
    public Object getList2(
            @RequestParam(value = "page", defaultValue = "1")
                    Integer pageNum,
            HttpSession session,
            @RequestParam(value = "limit", defaultValue = "5")
                    Integer pageSize,
            @RequestParam(value = "content", required = false)
                    String content) {

        Page<Pet> page = new Page<>(pageNum, pageSize);

        petService.getPetspersonal(page, content);

        //检索到当前登录用户的领养记录
        User user = (User) session.getAttribute("user_session");
        Integer userId = user.getId();
        List<Pet> list = page.getRecords();
        ArrayList<Object> arrayList = new ArrayList<>();
        list.forEach(item -> {
            Integer id = item.getUserId();
            if (id.equals(userId)) {//找到了登录用户的记录
                arrayList.add(item);
            }
        });

        Map<String, Object> map = new HashMap<>();
        map.put("list", arrayList);
        map.put("count", page.getTotal());
        map.put("limit", page.getSize());
        map.put("page", page.getCurrent());
        map.put("pages", page.getPages());
        map.put("nextPage", page.hasNext() ? page.getCurrent() + 1 : page.getCurrent());
        map.put("prePage", page.hasPrevious() ? page.getCurrent() - 1 : page.getCurrent());
        return map;
    }

    @ResponseBody
    @RequestMapping("/delAdopt")
    public Object delAdopt(Integer petId, HttpSession session) {
        User user = (User) session.getAttribute("user_session");
        Integer userId = user.getId();
        QueryWrapper<Adopt> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id", userId).eq("pet_id", petId);
        Adopt adopt = adoptService.getOne(wrapper, false);
        if (adopt != null) {
            HashMap<Object, Object> map = new HashMap<>();
            boolean b = adoptService.removeById(adopt.getId());
            if (b = true) {
                //删除成功
                map.put("msg", true);

            } else {
                map.put("msg", false);
            }
            return map;
        } else {
            HashMap<Object, Object> map = new HashMap<>();
            map.put("msg", "未查到记录");
            return map;
        }
    }


    @RequestMapping("/toSendAdopt")
    public String toSendAdopt(Model model) {
        List<Category> list = categoryService.list();
        model.addAttribute("categoryList", list);
        return "user/sendAdopt";
    }


    @RequestMapping("/SendAdopt")
    public String add(Pet pet) {
        Date now = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String cteatetime = format.format(now);
        pet.setCreatetime(cteatetime);

        petService.saveOrUpdate(pet);
        return "user/petList";
    }


    @RequestMapping("/toEditPersonal")
    public String toUpd(Model model, HttpSession session) {
        //查数据
        User user2 = (User) session.getAttribute("user_session");
        Integer userId = user2.getId();
        User user = userService.getById(userId);
        Date birthday = user.getBirthday();
        if (birthday==null){
            model.addAttribute("user", user);
        }else {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String s = sdf.format(birthday);
            model.addAttribute("birthday", s);
            model.addAttribute("user", user);
        }

        return "user/editPersonal";
    }

    @RequestMapping("/toEditPersonal2")
    public String toUpd2(Model model, HttpSession session) {
        //查数据
        User user2 = (User) session.getAttribute("user_session");
        Integer userId = user2.getId();
        User user = userService.getById(userId);
        Date birthday = user.getBirthday();
        if (birthday==null){
            model.addAttribute("user", user);
        }else {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String s = sdf.format(birthday);
            model.addAttribute("birthday", s);
            model.addAttribute("user", user);
        }
        return "user/editPersonal2";
    }

    @RequestMapping("/toEditPassword")
    public String toEditPassword() {
        return "user/editPassword";
    }

    @ResponseBody
    @RequestMapping("/editPassword")
    public Object editPassword(String password, HttpSession session) {
        User user = (User) session.getAttribute("user_session");
        //MD5加密
        String s = DigestUtils.md5DigestAsHex(password.getBytes());
        user.setPassword(s);
        boolean b = userService.saveOrUpdate(user);
        if (b == true) {

            return "密码修改成功";
        } else {

            return "密码修改失败";
        }

    }


    @ResponseBody
    @RequestMapping("/updPersonal")
    public Object updPersonal(User user,HttpSession session,String birthdays) throws ParseException {
        String imgpath = user.getImgpath();


        if (imgpath == null || "".equals(imgpath)) {
            //这种只更新其他属性，不更新宠物图片的操作，需要查回原来的图片路径，再设置回去，不然修改后图片会丢失
            Integer id = user.getId();
            User user1 = userService.getById(id);
            String imgpath1 = user1.getImgpath();
            user.setImgpath(imgpath1);//查回原来的图片路径，再设置回去，就不会出现图片丢失的bug了
        }

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = format.parse(birthdays);
        user.setBirthday(date);
        boolean b = userService.saveOrUpdate(user);
        if (b == true) {
            session.setAttribute("user_session",user);
            return "信息更新成功";
        } else {
            return "信息更新失败";
        }


    }

}
