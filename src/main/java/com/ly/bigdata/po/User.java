package com.ly.bigdata.po;

import com.baomidou.mybatisplus.annotation.IdType;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import sun.management.Agent;

/**
 * <p>
 *
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-12
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;


    /**
     * 登录名
     */
    private String loginname;

    private String password;

    private String realname;

    private String phone;

    private String email;

    /**
     * 头像图片的路径
     */
    private String imgpath;

    private Date birthday;


    /**
     * 0代表男；1代表女
     */
    private Integer sex;

    /**
     * 0代表无领养经历；1代表有领养经历
     */
    private Integer adoptEx;

    /**
     * 用户住址
     */
    private String address;


    private Date createdate;

    public String getTimestr() {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        String s = format.format(this.createdate);
        return s;
    }


    public String getAge() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        if (this.birthday != null) {
            return getUserAge(sdf.format(this.birthday));
        }
        return null;

    }

    //根据数据库的生日计算用户的年龄
    public String getUserAge(String str1) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str2 = sdf.format(date);
        Calendar bef = Calendar.getInstance();
        Calendar aft = Calendar.getInstance();
        try {
            bef.setTime(sdf.parse(str1));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        try {
            aft.setTime(sdf.parse(str2));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        int surplus = aft.get(Calendar.DATE) - bef.get(Calendar.DATE);
        int result = aft.get(Calendar.MONTH) - bef.get(Calendar.MONTH);
        int year = aft.get(Calendar.YEAR) - bef.get(Calendar.YEAR);
//        System.out.println(result);
        if (result < 0) {
            result = 1;
        } else if (result == 0) {
            result = surplus <= 0 ? 0 : 1;
        } else {
            result = 0;
        }
//        System.out.println(result);
//        System.out.println("相差年份：" + (year + result));
        Integer diff = year + result;
        return diff.toString();
    }
}
