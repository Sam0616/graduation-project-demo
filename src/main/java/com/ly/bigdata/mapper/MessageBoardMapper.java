package com.ly.bigdata.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.MessageBoard;
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
public interface MessageBoardMapper extends BaseMapper<MessageBoard> {
    List<MessageBoard> getMessageBoards(Page<MessageBoard> page, @Param("content") String content);
}
