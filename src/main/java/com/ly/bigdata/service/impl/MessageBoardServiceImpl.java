package com.ly.bigdata.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Comment;
import com.ly.bigdata.po.MessageBoard;
import com.ly.bigdata.mapper.MessageBoardMapper;
import com.ly.bigdata.service.MessageBoardService;
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
public class MessageBoardServiceImpl extends ServiceImpl<MessageBoardMapper, MessageBoard> implements MessageBoardService {

    @Autowired
    private MessageBoardMapper messageBoardMappe;

    @Override
    public List<MessageBoard> getMessageBoards(Page<MessageBoard> page, String content) {
        if (content == null) {
            content = "";
        }
        List<MessageBoard> list = messageBoardMappe.getMessageBoards(page, "%" + content + "%");
        page.setRecords(list);
        return list;
    }
}
