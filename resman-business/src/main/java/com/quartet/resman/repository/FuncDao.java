package com.quartet.resman.repository;

import com.quartet.resman.entity.Func;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

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
}
