package com.quartet.resman.repository;

import com.quartet.resman.entity.Notice;
import com.quartet.resman.entity.Ques;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * User: qfxu
 * Date: 15-1-12
 */
public interface QuesDao extends JpaRepository<Ques, Long>, JpaSpecificationExecutor<Ques> {
}
