package com.ly.bigdata.service.impl;

import com.ly.bigdata.po.Category;
import com.ly.bigdata.mapper.CategoryMapper;
import com.ly.bigdata.service.CategoryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-14
 */
@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {

}
