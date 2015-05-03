package com.quartet.resman.repository;

import com.quartet.resman.entity.DocCourse;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by lcheng on 2015/5/1.
 */
public interface DocCourseDao extends JpaRepository<DocCourse,Long> {

    public List<DocCourse> findByDocUid(String uid);
}
