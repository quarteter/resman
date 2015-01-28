package com.quartet.resman.repository;

import com.quartet.resman.entity.CourseStudent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * @author qfxu
 * @version 1.0
 *          ${tags}
 */
public interface CourseStudentDao extends JpaRepository<CourseStudent, Long> {

    @Query("from CourseStudent t where t.user.id = ?1 and t.course.id = ?2")
    public List<CourseStudent> findByUserAndCourse(Long userid, Long courseId);

    @Query("from CourseStudent t where t.course.id = ?1")
    public List<CourseStudent> findByCourse(Long courseId);

}
