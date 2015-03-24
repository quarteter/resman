package com.quartet.resman.repository;

import com.quartet.resman.vo.QuestionVo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * User: qfxu
 * Date: 15-1-12
 */
public interface QuestionVoDao extends JpaRepository<QuestionVo, Long>, JpaSpecificationExecutor<QuestionVo> {
}
