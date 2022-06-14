package com.yang.service.impl;

import com.yang.bean.Evaluate;
import com.yang.mapper.EvaluateMapper;
import com.yang.service.EvaluateService;
import com.yang.vo.EvaluateVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author yang
 * @date 2021/11/25 - 14:50
 */
@Service
public class EvaluateServiceImpl implements EvaluateService {
    @Autowired
    private EvaluateMapper evaluateMapper;

    @Override
    public List<Evaluate> findEvaluateList(EvaluateVo evaluateVo) {
        return evaluateMapper.findEvaluateList(evaluateVo);
    }

    @Override
    public int addEvaluate(Evaluate evaluate) {
        return evaluateMapper.addEvaluate(evaluate);
    }

    @Override
    public int deleteById(int id) {
        return evaluateMapper.deleteById(id);
    }

    @Override
    public int findTotalEvaluate() {
        return evaluateMapper.findTotalEvaluate();
    }
}
