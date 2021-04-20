package com.ly.bigdata.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Adopt;
import com.ly.bigdata.po.Pet;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-16
 */
@Component
public interface AdoptMapper extends BaseMapper<Adopt> {
    List<Adopt> getAdopts(Page<Adopt> page, @Param("content")String content);
}
