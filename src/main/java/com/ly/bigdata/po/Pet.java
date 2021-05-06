package com.ly.bigdata.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serializable;
import java.text.SimpleDateFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 *
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-14
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Pet implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 动物编号
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 宠物名称
     */
    private String petname;
    /**
     * 外键；宠物的类别
     */
    private Integer categoryId;

    /**
     * 外键；宠物的品种
     */
    private Integer varietyId;

    /**
     * 图片路径
     */
    private String imgpath;

    /**
     * 宠物的大致年龄
     */
    private String age;

    /**
     * 宠物来源（0：流浪动物；1；送养动物）
     */
    private Integer source;

    /**
     * （0:雄性；1：雌性）
     */
    private Integer sex;

    /**
     * 领养状态（0：待领养；1：申请中；2：被领养）
     */
    private Integer status;

    /**
     * 描述
     */
    private String description;

    /**
     * 宠物的地理位置（备用字段）
     */
    private String area;

    /**
     * 疫苗接种状态（0：未接种；1：已经接种）
     */
    private Integer vaccine;

    private String createtime;


 /*   public String getTimestr() {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        String s = format.format(this.createtime);
        return s;
    }*/

    @TableField(exist = false)
    public String vname;
    @TableField(exist = false)
    public String cname;
    @TableField(exist = false)
    public String atime;
    @TableField(exist = false)
    public String amsg;
    @TableField(exist = false)
    public String vtype;


}
