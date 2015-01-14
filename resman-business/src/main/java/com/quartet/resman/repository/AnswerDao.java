package com.quartet.resman.repository;

import com.quartet.resman.entity.Answer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * User: xwang
 * Date: 15-1-14
 */
public interface AnswerDao extends JpaRepository<Answer, Long>, JpaSpecificationExecutor<Answer> {
}
