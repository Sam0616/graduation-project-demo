package com.ly.bigdata.po;

import com.baomidou.mybatisplus.annotation.IdType;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * <p>
 *
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-11
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
public class Admin implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键，编号
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 登录名
     */
    private String loginname;

    /**
     * 登录密码
     */
    private String password;

    /**
     * 姓名
     */
    private String realname;

    /**
     * 0代表男 1代表女
     */
    private Integer sex;

    /**
     * 电话
     */
    private String phone;

    private Date birthday;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 开户日期
     */
    private Date createdate;

    /**
     * 0代表普通管理员 1代表超级管理员
     */
    private Integer role;

    /**
     * 头像
     */
    private String imgpath;


    public String getTimestr() {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        String s = format.format(this.birthday);
        return s;
    }
    public String getTimestr2() {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        String s = format.format(this.createdate);
        return s;
    }

}
