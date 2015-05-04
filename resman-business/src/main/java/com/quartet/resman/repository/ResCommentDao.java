package com.quartet.resman.repository;

import com.quartet.resman.entity.ResComment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Administrator on 2015/3/25.
 */
public interface ResCommentDao extends JpaRepository<ResComment,Long> {

    public Page<ResComment> findByResIdOrderByCrtdateDesc(String resId,Pageable page);
}
