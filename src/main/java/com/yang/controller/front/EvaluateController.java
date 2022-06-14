package com.yang.controller.front;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yang.bean.Evaluate;
import com.yang.bean.User;
import com.yang.service.EvaluateService;
import com.yang.service.OrderService;
import com.yang.utils.DataGridViewResult;
import com.yang.utils.SystemConstant;
import com.yang.vo.EvaluateVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/evaluate")
public class EvaluateController {
    @Autowired
    private EvaluateService evaluateService;
    @Autowired
    private OrderService orderService;

    /**
     * 评价列表
     * @param evaluateVo
     * @return
     */
    @RequestMapping("list")
    @ResponseBody
    public DataGridViewResult list(EvaluateVo evaluateVo) {
        //设置分页信息
        PageHelper.startPage(evaluateVo.getPage(), evaluateVo.getLimit());
        //调用分页查询的方法
        List<Evaluate> evaluateList = evaluateService.findEvaluateList(evaluateVo);
        System.out.println(evaluateList);
        //创建分页对象
        PageInfo<Evaluate> pageInfo = new PageInfo<>(evaluateList);
        return new DataGridViewResult(pageInfo.getTotal(), pageInfo.getList());
    }


    /**
     * 用户发布评价
     * @param evaluate
     * @param orderId
     * @param session
     * @return
     */
    @RequestMapping("/addEvaluate")
    @ResponseBody
    private Map<Object, Object> addEvaluate(Evaluate evaluate, int orderId, HttpSession session) {
        Map<Object, Object> map = new HashMap<>();
        System.out.println("订单id"+orderId);
        System.out.println("评价："+evaluate);
        //取到session里的值
        User u = (User) session.getAttribute("user");
        if (u == null) {
            map.put(SystemConstant.MESSAGE, "SessionError");
        } else {
            orderService.finishOrder(orderId);
            evaluate.setUid(u.getId());
            evaluate.setAddTime(new Date());
            if (evaluateService.addEvaluate(evaluate) > 0) {
                map.put(SystemConstant.MESSAGE, "true");
            } else {
                map.put(SystemConstant.MESSAGE, "false");
            }
        }
        return map;
    }


    /**
     * 删除评价
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    @ResponseBody
    public Map<Object, Object> deleteById(int id){
        Map<Object, Object> map = new HashMap<>();
        if(evaluateService.deleteById(id)>0){
            map.put(SystemConstant.SUCCESS,true);//成功
            map.put(SystemConstant.MESSAGE,"删除成功");
        }else{
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"删除失败");
        }
        return map;
    }
}
