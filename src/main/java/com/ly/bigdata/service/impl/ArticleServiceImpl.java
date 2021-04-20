package com.ly.bigdata.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Adopt;
import com.ly.bigdata.po.Article;
import com.ly.bigdata.mapper.ArticleMapper;
import com.ly.bigdata.service.ArticleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-17
 */
@Service
public class ArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements ArticleService {

    @Autowired
    private ArticleMapper articleMapper;

    @Override
    public List<Article> getArticles(Page<Article> page, String content) {
        if (content == null) {
            content = "";
        }
        List<Article> list = articleMapper.getArticles(page, "%" + content + "%");
        page.setRecords(list);
        return list;
    }
}
