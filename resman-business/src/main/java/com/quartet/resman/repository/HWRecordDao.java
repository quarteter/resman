package com.quartet.resman.repository;

import com.quartet.resman.entity.HomeWorkRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by lcheng on 2015/6/20.
 */
public interface HWRecordDao extends JpaRepository<HomeWorkRecord,Long> {

    @Modifying
    @Query(value = "delete from HomeWorkRecord r where r.hkId = ?1")
    void deleteHomeworkRecords(Long hwid);

    @Modifying
    @Query(value = "delete from HomeWorkRecord r where r.hkId = ?1 and r.submitterId = ?2 ")
    void deleteByHkIdAndSubmitterId(Long hwid , Long submitterId );

    @Modifying
    @Transactional
    @Query(value = "update HomeWorkRecord r set r.score=?2 where r.id = ?1")
    void updateScore(Long id,float score);

    List<HomeWorkRecord> findByHkIdAndSubmitterLike(Long hkId,String submitter);

    List<HomeWorkRecord> findByHkId(Long hkId);

    HomeWorkRecord findByHkIdAndSubmitterId(Long hkId , Long submitterId );
}
