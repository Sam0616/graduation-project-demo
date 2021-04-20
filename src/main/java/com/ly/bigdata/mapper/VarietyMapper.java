package com.ly.bigdata.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Variety;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-14
 */
@Component
public interface VarietyMapper extends BaseMapper<Variety> {
    List<Variety> getVarieties(Page<Variety> page, @Param("content")String content);
}
