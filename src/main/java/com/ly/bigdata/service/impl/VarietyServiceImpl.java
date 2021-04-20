package com.ly.bigdata.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Pet;
import com.ly.bigdata.po.Variety;
import com.ly.bigdata.mapper.VarietyMapper;
import com.ly.bigdata.service.VarietyService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author 陈太康
 * @since 2021-04-14
 */
@Service
public class VarietyServiceImpl extends ServiceImpl<VarietyMapper, Variety> implements VarietyService {

    @Autowired
    private VarietyMapper varietyMapper;


    @Override
    public List<Variety> getVarieties(Page<Variety> page, String content) {

        if (content == null) {
            content = "";
        }
        List<Variety> list = varietyMapper.getVarieties(page, "%" + content + "%");
        page.setRecords(list);
        return list;
    }
}
