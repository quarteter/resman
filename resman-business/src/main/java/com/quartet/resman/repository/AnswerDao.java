package com.quartet.resman.repository;

import com.quartet.resman.entity.Answer;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * User: xwang
 * Date: 15-1-14
 */
public interface AnswerDao extends JpaRepository<Answer, Long> {
    @Query("from Answer t where t.question.id = ?1")
    public List<Answer> findByQuestion(Long courseId);

    @Query("from Answer t where t.question.id = ?1")
    public Page<Answer> findByQuestion(Long courseId,Pageable page);

}
