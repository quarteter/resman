package com.quartet.resman.repository;

import com.quartet.resman.entity.HomeWork;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * Created by lcheng on 2015/6/20.
 */
public interface HomeWorkDao extends JpaRepository<HomeWork,Long>,JpaSpecificationExecutor<HomeWork> {
}
