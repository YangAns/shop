package com.yang.service;

import com.yang.bean.Collect;

import java.util.List;

/**
 * @author yang
 * @date 2021/11/28 - 16:19
 */
public interface CollectService {
    /**
     * 根据用户查询收藏列表
     * @param uid
     * @return
     */
    List<Collect> findCollectListByUid(int uid);

    /**
     * 用户添加收藏
     * @param collect
     * @return
     */
    int addCollect(Collect collect);

    /**
     * 用户取消收藏
     * @param id
     * @return
     */
    int deleteById(int id);

    Collect findCollectByUidGid(int uid, int gid);
}
