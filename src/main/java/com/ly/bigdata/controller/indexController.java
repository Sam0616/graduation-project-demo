package com.ly.bigdata.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class indexController {


    //去后台界面
    @RequestMapping("/back")
    public String toIndex() {
        return "admin/index";
    }

    //去前台界面
    @RequestMapping("/front")
    public String toIndex2() {
        return "user/index";
    }

    @RequestMapping("/")
    public String tologin() {
        return "login";
    }

    @RequestMapping("/tologin")
    public String tologin2() {
        return "login";
    }


    @RequestMapping("/userlogout")
    public String userlogout(HttpSession session){
        session.invalidate();
        return "login";
    }

    @RequestMapping("/logout")
    public String adminlogout(HttpSession session){
        session.invalidate();
        return "login";
    }

    @RequestMapping("/toFirstPage")
    public String toFirstPage() {
        return "admin/firstPage";
    }

}
