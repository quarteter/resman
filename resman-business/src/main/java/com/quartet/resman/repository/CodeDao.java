package com.quartet.resman.repository;

import com.quartet.resman.entity.Code;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by lcheng on 2015/3/31.
 */
public interface CodeDao extends JpaRepository<Code,Long>{

    public List<Code> findByCategoryOrderBySeqNoAsc(String category);
}
