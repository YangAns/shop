package com.yang.service;

import com.yang.bean.Evaluate;
import com.yang.vo.EvaluateVo;

import java.util.List;

/**
 * @author yang
 * @date 2021/11/25 - 14:49
 */
public interface EvaluateService {

    /**
     * 查询评论列表
     * @param evaluateVo
     * @return
     */
    List<Evaluate> findEvaluateList(EvaluateVo evaluateVo);
    /**
     * 前台用户发布评价
     * @param evaluate
     * @return
     */
    int addEvaluate(Evaluate evaluate);

    /**
     * 删除评价
     * @param id
     * @return
     */
    int deleteById(int id);

    /**
     * 查询总评价数量
     * @return
     */
    int findTotalEvaluate();
}
