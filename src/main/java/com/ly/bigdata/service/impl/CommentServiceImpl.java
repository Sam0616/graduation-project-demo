package com.ly.bigdata.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Article;
import com.ly.bigdata.po.Comment;
import com.ly.bigdata.mapper.CommentMapper;
import com.ly.bigdata.service.CommentService;
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
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements CommentService {

    @Autowired
    private CommentMapper commentMapper;
    @Override
    public List<Comment> getComments(Page<Comment> page, String content) {
        if (content == null) {
            content = "";
        }
        List<Comment> list = commentMapper.getComments(page, "%" + content + "%");
        page.setRecords(list);
        return list;
    }
}
