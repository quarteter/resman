package com.quartet.resman.repository;

import com.quartet.resman.entity.News;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Administrator on 2015/3/25.
 */
public interface NewsDao extends JpaRepository<News,Long> {

    public Page<News> findByPublish(boolean publish,Pageable page);
}
