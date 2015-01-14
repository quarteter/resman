package com.quartet.resman.repository;

import com.quartet.resman.entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * User: qfxu
 * Date: 15-1-12
 */
public interface QuestionDao extends JpaRepository<Question, Long>, JpaSpecificationExecutor<Question> {
}
