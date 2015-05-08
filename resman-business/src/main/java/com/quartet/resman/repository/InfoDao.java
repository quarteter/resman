package com.quartet.resman.repository;

import com.quartet.resman.entity.Info;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

/**
 * Created by Administrator on 2015/3/25.
 */
public interface InfoDao extends JpaRepository<Info, Long>,JpaSpecificationExecutor<Info> {

    public Page<Info> findByPublish(boolean publish, Pageable page);

    public Page<Info> findByType(String type,Pageable page);

    public Page<Info> findByTypeAndPublish(String type, boolean publish, Pageable page);


    @Query("from Info t  where t.type=?1 and t.publish = ?2 and t.imgPath is not null and t.imgPath <> ''")
    public Page<Info> findByTypeAndPublishHasImage(String type, boolean publish, Pageable page);

    @Query("update Info i set i.publish= ?2 where i.id=?1")
    @Modifying
    public void updateInfoPublishState(Long id,boolean publish);

    @Query("update Info i set i.readCount= i.readCount+1 where i.id =?1")
    @Modifying
    public void updateInfoReadCount(Long id);

}
