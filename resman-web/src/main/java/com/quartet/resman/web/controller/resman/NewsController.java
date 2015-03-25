package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.News;
import com.quartet.resman.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Administrator on 2015/3/25.
 */
@Controller
@RequestMapping("/news")
public class NewsController {

    @Autowired
    private NewsService newsService;

    @RequestMapping
    public ModelAndView list(@PageableDefault(sort = {"crtdate"},direction = Sort.Direction.DESC)Pageable page){
        ModelAndView mv = new ModelAndView("resman/news-list");
        Page<News> data = newsService.getNews(page);
        mv.addObject("news",data.getContent());
        return mv;
    }
}
