package com.ly.bigdata.po;

import com.baomidou.mybatisplus.annotation.IdType;
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
 * @since 2021-04-14
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Category implements Serializable {

    private static final long serialVersionUID=1L;

    /**
     * 宠物类别的id
     */
      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 种类名称
     */
    private String name;


}
