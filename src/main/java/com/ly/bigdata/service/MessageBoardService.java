package com.ly.bigdata.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.MessageBoard;
import com.baomidou.mybatisplus.extension.service.IService;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-17
 */
public interface MessageBoardService extends IService<MessageBoard> {
    List<MessageBoard> getMessageBoards(Page<MessageBoard> page, @Param("content") String content);
}
