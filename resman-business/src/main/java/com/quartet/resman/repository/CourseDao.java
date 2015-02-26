package com.quartet.resman.repository;

import com.quartet.resman.entity.Course;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

/**
 * @author qfxu
 * @version 1.0
 *          ${tags}
 */
public interface CourseDao extends JpaRepository<Course, Long>, JpaSpecificationExecutor<Course> {

    public Page<Course> findByParent(Long pid, Pageable page);

    public Page<Course> findByParent(Long pid, Specification spec, Pageable page);

    public List<Course> findByParent(Long pid);

}
