package com.ly.bigdata.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 *
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-16
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Adopt implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Integer userId;

    private Integer petId;

    /**
     * 申请领养的理由
     */
    private String message;

    /**
     * 微信号，选填
     */
    private String wechat;

    private String phone;

    private String address;

    /**
     * 外键：审核状态
     */
    private Integer verifyStatusId;

    private String createtime;


    //宠物名
    @TableField(exist = false)
    private String pname;

    //用户名
    @TableField(exist = false)
    private String uname;

    //动物领养审核状态
    @TableField(exist = false)
    private String vtype;

    //用户的手机号
    @TableField(exist = false)
    private String uphone;

    //用户的地址
    @TableField(exist = false)
    private String uaddress;

}
