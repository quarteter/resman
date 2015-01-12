package com.quartet.resman.repository;

import com.quartet.resman.entity.Notice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * User: qfxu
 * Date: 15-1-8
 */
public interface NoticeDao extends JpaRepository<Notice, Long>, JpaSpecificationExecutor<Notice> {
}
