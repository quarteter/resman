package com.quartet.resman.repository;

import com.quartet.resman.entity.Question;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * User: qfxu
 * Date: 15-1-12
 */
public interface QuestionDao extends JpaRepository<Question, Long>, JpaSpecificationExecutor<Question> {

    @Query("select distinct q from Question q join q.answers a join a.crtuser u where u.id = ?1")
    public Page<Question> findQuestionByAnswerUser(Long userID, Pageable page);
}
