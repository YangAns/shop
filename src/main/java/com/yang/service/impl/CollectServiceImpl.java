package com.yang.service.impl;

import com.yang.bean.Collect;
import com.yang.mapper.CollectMapper;
import com.yang.service.CollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CollectServiceImpl implements CollectService {
    @Autowired
    private CollectMapper collectMapper;
    @Override
    public List<Collect> findCollectListByUid(int uid) {
        return collectMapper.findCollectListByUid(uid);
    }

    @Override
    public int addCollect(Collect collect) {
        return collectMapper.addCollect(collect);
    }

    @Override
    public int deleteById(int id) {
        return collectMapper.deleteById(id);
    }

    @Override
    public Collect findCollectByUidGid(int uid, int gid) {
        return collectMapper.findCollectByUidGid(uid,gid);
    }
}
