package com.ly.bigdata.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;

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
public class Article implements Serializable {

    private static final long serialVersionUID=1L;

      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String title;

    /**
     * 文章内容
     */
    private String content;

    private String createtime;

    /**
     * 文章来源，如官方发布（备用字段）
     */
    private String source;

    private String articleType;

    /**
     * 发布人，外键，发布文章的管理员id
     */
    private Integer adminId;


    @TableField(exist = false)
    private String adname;

    @TableField(exist = false)
    private String imgpath;
    @TableField(exist = false)
    private String adphone;
    @TableField(exist = false)
    private String ademail;

}
