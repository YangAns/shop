package com.yang.mapper;

import com.yang.bean.Collect;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CollectMapper {

    /**
     * 根据用户查询收藏列表
     * @param uid
     * @return
     */
    List<Collect> findCollectListByUid(@Param("uid") int uid);

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


    //判断该商品是否已经收藏过了
    Collect findCollectByUidGid(@Param("uid") int uid, @Param("gid") int gid);
}
