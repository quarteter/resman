package com.quartet.resman.service;

import com.quartet.resman.entity.News;
import com.quartet.resman.repository.NewsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/3/25.
 */
@Service
public class NewsService {

    @Autowired
    private NewsDao newsDao;

    public Page<News> getNews(Pageable page){
        return newsDao.findAll(page);
    }

    public Page<News> getNews(boolean publish,Pageable page){
        return newsDao.findByPublish(publish, page);
    }

    public News getNews(Long id){
        return newsDao.findOne(id);
    }

    public void addNews(News news){
        newsDao.save(news);
    }

    public void deleteNews(Long id){
        newsDao.delete(id);
    }
}
