package com.quartet.resman.repository;

import com.quartet.resman.entity.Course;
import com.quartet.resman.vo.HomeWorkVo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * Created by XWANG on 2015/2/27.
 */
public interface HomeWorkVoDao extends JpaRepository<HomeWorkVo, Long>, JpaSpecificationExecutor<HomeWorkVo> {

}
