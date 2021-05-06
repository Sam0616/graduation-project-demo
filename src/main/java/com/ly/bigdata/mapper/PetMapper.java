package com.ly.bigdata.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Pet;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-14
 */
@Component
public interface PetMapper extends BaseMapper<Pet> {
     List<Pet> getPets(Page<Pet> page, @Param("content")String content);
     List<Pet> getPetsFront(Page<Pet> page, @Param("content")String content);//前台策略是不显示已经被领养
     List<Pet> getPetspersonal(Page<Pet> page, @Param("content")String content);//个人申请的宠物列表

}
