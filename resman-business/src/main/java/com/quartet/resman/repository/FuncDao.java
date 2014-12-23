package com.quartet.resman.repository;

import com.quartet.resman.entity.Func;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public interface FuncDao extends JpaRepository<Func,Long> {

    public List<Func> findByParentOrderBySeqNoAsc(Long pid);

    public List<Func> findByParentOrderByLevelAscSeqNoAsc(Long uid);

    public Page<Func> findByParent(Long pid, Pageable page);

    public List<Func> findByParentAndLeafFalseOrderBySeqNoAsc(Long pid);

    public Page<Func> findByParentAndLeafTrueOrderBySeqNoAsc(Long pid, Pageable page);

    public List<Func> findByLevelOrderBySeqNoAsc(int level);

    @Query(value = "update Func f set f.seqNo = f.seqNo+5 where f.parent = ?1 and f.seqNo>= ?2 and f.seqNo <?3")
    @Modifying
    public void updateSeqNoPre(Long parent,Integer targetSeqNo,Integer srcSeqNo);

    @Query(value = "update Func f set f.seqNo = f.seqNo+5 where f.parent = ?1 and f.seqNo>= ?2")
    @Modifying
    public void updateSeqNoPre(Long parent,Integer targetSeqNo);

    @Query(value = "update Func f set f.seqNo = f.seqNo+5 where f.parent = ?1 and f.seqNo> ?2 and f.seqNo <?3")
    @Modifying
    public void updateSeqNoNext(Long parent,Integer targetSeqNo,Integer srcSeqNo);

    @Query(value = "update Func f set f.seqNo = f.seqNo+5 where f.parent = ?1 and f.seqNo> ?2")
    @Modifying
    public void updateSeqNoNext(Long parent,Integer targetSeqNo);
}
