package com.yang.service.impl;

import com.yang.bean.Notice;
import com.yang.mapper.NoticeMapper;
import com.yang.service.NoticeService;
import com.yang.vo.NoticeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @author yang
 * @date 2021/11/14 - 10:49
 */
@Service
public class NoticeServiceImpl implements NoticeService {
    @Autowired
    private NoticeMapper noticeMapper;
    @Override
    public List<Notice> findNoticeList(NoticeVo noticeVo) {
        return noticeMapper.findNoticeList(noticeVo);
    }

    @Override
    public int addNotice(Notice notice) {
        notice.setAddTime(new Date());
        return noticeMapper.addNotice(notice);
    }

    @Override
    public int updateNotice(Notice notice) {
        return noticeMapper.updateNotice(notice);
    }

    @Override
    public int deleteById(int id) {
        return noticeMapper.deleteById(id);
    }

    @Override
    public Notice findNewNotice() {
        return noticeMapper.findNewNotice();
    }

    @Override
    public Notice findNoticeById(int id) {
        return noticeMapper.findNoticeById(id);
    }
}
