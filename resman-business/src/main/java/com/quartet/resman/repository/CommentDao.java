package com.quartet.resman.repository;

import com.quartet.resman.entity.Comment;
import com.quartet.resman.entity.Course;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

/**
 * Created by XWANG on 2015/3/22.
 */
public interface CommentDao  extends JpaRepository<Comment, Long>, JpaSpecificationExecutor<Comment> {
    public Page<Comment> findByResourceidAndType(Long resourceid,Comment.CommentType type, Pageable page);
    public List<Comment> findByResourceidAndType(Long resourceid,Comment.CommentType type );
}
