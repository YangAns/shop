package com.yang.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yang.bean.Notice;
import com.yang.service.NoticeService;
import com.yang.utils.DataGridViewResult;
import com.yang.utils.SystemConstant;
import com.yang.vo.NoticeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 公告管理
 */
@Controller
@RequestMapping("/admin/notice")
public class NoticeController {
    @Autowired
    private NoticeService noticeService;

    /**
     * 公告列表
     * @param noticeVo
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public DataGridViewResult list(NoticeVo noticeVo){
        //设置分页信息
        PageHelper.startPage(noticeVo.getPage(),noticeVo.getLimit());
        //调用分页查询的方法
        List<Notice> noticeList = noticeService.findNoticeList(noticeVo);
        //创建分页对象
        PageInfo<Notice> pageInfo = new PageInfo<>(noticeList);
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }


    /**
     * 发布公告
     * @param notice
     * @return
     */
    @RequestMapping("/addNotice")
    @ResponseBody
    public Map<Object, Object> addNotice(Notice notice){
        Map<Object, Object> map = new HashMap<>();
        if(noticeService.addNotice(notice)>0){
            map.put(SystemConstant.SUCCESS,true);//成功
            map.put(SystemConstant.MESSAGE,"添加成功");
        }else{
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"添加失败");
        }
        return map;
    }

    /**
     * 修改公告
     * @param notice
     * @return
     */
    @RequestMapping("/updateNotice")
    @ResponseBody
    public Map<Object, Object> updateNotice(Notice notice){
        Map<Object, Object> map = new HashMap<>();
        if(noticeService.updateNotice(notice)>0){
            map.put(SystemConstant.SUCCESS,true);//成功
            map.put(SystemConstant.MESSAGE,"修改成功");
        }else{
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"修改失败");
        }
        return map;
    }

    /**
     * 删除公告
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    @ResponseBody
    public Map<Object, Object> deleteById(int id){
        Map<Object, Object> map = new HashMap<>();
        if(noticeService.deleteById(id)>0){
            map.put(SystemConstant.SUCCESS,true);//成功
            map.put(SystemConstant.MESSAGE,"删除成功");
        }else{
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"删除失败");
        }
        return map;
    }
}
