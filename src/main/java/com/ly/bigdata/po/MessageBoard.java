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
 * @since 2021-04-17
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class MessageBoard implements Serializable {

    private static final long serialVersionUID=1L;

      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 留言用户的id
     */
    private Integer userId;

    private String createtime;

    private String title;

    private String content;

    /**
     * 留言的审核（0：未审核，1：通过审核，2：审核不通过，不能显示）
     */
    private Integer status;

    @TableField(exist = false)
    private String uname;
    @TableField(exist = false)
    private String uemail;
    @TableField(exist = false)
    private String uphone;


}
