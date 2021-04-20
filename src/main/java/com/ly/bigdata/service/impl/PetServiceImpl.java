package com.ly.bigdata.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.bigdata.po.Pet;
import com.ly.bigdata.mapper.PetMapper;
import com.ly.bigdata.service.PetService;
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
public class PetServiceImpl extends ServiceImpl<PetMapper, Pet> implements PetService {

    @Autowired
    private PetMapper petMapper;

    @Override
    public List<Pet> getPets(Page<Pet> page, String content) {
        if (content == null) {
            content = "";
        }
        List<Pet> list = petMapper.getPets(page, "%" + content + "%");
        page.setRecords(list);
        return list;




    }
}
