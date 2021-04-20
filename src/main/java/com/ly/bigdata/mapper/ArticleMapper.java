package com.ly.bigdata.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Adopt;
import com.ly.bigdata.po.Article;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-17
 */
@Component
public interface ArticleMapper extends BaseMapper<Article> {
    List<Article> getArticles(Page<Article> page, @Param("content")String content);

}
