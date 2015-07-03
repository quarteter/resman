package com.quartet.resman.repository;

import com.quartet.resman.vo.HomeWorkVo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by XWANG on 2015/2/27.
 */
public interface HomeWorkVoDao extends JpaRepository<HomeWorkVo, Long>, JpaSpecificationExecutor<HomeWorkVo> {
    Page<HomeWorkVo> findBySubmitterId(Long submitterId ,Pageable page);
}
