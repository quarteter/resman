package com.quartet.resman.repository;

import com.quartet.resman.entity.Code;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

/**
 * Created by lcheng on 2015/3/31.
 */
public interface CodeDao extends JpaRepository<Code,Long>,JpaSpecificationExecutor<Code>{

    public List<Code> findByCategoryOrderBySeqNoAsc(String category);

    public Code findByCategoryAndCode(String category , String code );
}
