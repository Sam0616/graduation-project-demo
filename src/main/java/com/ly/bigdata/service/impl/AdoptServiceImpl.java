package com.ly.bigdata.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Adopt;
import com.ly.bigdata.mapper.AdoptMapper;
import com.ly.bigdata.po.Pet;
import com.ly.bigdata.service.AdoptService;
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
 * @since 2021-04-16
 */
@Service
public class AdoptServiceImpl extends ServiceImpl<AdoptMapper, Adopt> implements AdoptService {

    @Autowired
    private AdoptMapper adoptMapper;

    @Override
    public List<Adopt> getAdopts(Page<Adopt> page, String content) {
        if (content == null) {
            content = "";
        }
        List<Adopt> list = adoptMapper.getAdopts(page, "%" + content + "%");
        page.setRecords(list);
        return list;
    }
}
