package com.yang.service;

import com.yang.bean.Notice;
import com.yang.vo.NoticeVo;

import java.util.List;

/**
 * @author yang
 * @date 2021/11/14 - 10:49
 */
public interface NoticeService {

    /**
     * 查询所有公告列表
     * @return
     */
    List<Notice> findNoticeList(NoticeVo noticeVo);

    /**
     * 添加公告
     * @param notice
     * @return
     */
    int addNotice(Notice notice);

    /**
     * 修改公告
     * @param notice
     * @return
     */
    int updateNotice(Notice notice);


    /**
     * 删除公告
     * @param id
     * @return
     */
    int deleteById(int id);

    /**
     * 查找最新发布的公告
     * @return
     */
    Notice findNewNotice();

    /**
     * 根据id查询一条公告
     * @param id
     * @return
     */
    Notice findNoticeById(int id);
}
