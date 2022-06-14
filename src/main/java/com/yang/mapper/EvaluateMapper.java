package com.yang.mapper;


import com.yang.bean.Evaluate;
import com.yang.vo.EvaluateVo;

import java.util.List;

public interface EvaluateMapper {

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
     * 根据商品id查询评价列表
     * @param id
     * @return
     */
    List<Evaluate> listEvaluateByGid(int id);

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
