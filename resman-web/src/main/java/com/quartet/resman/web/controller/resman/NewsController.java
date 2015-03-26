package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.News;
import com.quartet.resman.entity.Result;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.service.NewsService;
import com.quartet.resman.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;

/**
 * Created by Administrator on 2015/3/25.
 */
@Controller
@RequestMapping("/news")
public class NewsController {

    @Autowired
    private NewsService newsService;
    @Autowired
    private UserService userService;

    @RequestMapping("/list")
    public ModelAndView list(@PageableDefault(sort = {"crtdate"},direction = Sort.Direction.DESC)Pageable page){
        ModelAndView mv = new ModelAndView("resman/news-list");
        Page<News> data = newsService.getNews(page);
        mv.addObject("news",data.getContent());
        mv.addObject("totalPages",data.getTotalPages());
        mv.addObject("curPage",data.getNumber());
        return mv;
    }

    @RequestMapping(value = "/add",method = RequestMethod.GET)
    public String addNews(){
        return "resman/news-add";
    }

    @RequestMapping(value = "/add",method = RequestMethod.POST)
    public String addNews(News news){
        if (news!=null){
            ShiroUser user = userService.getCurrentUser();
            String userName = user.getUserName();
            news.setCrtuser(userName);
            news.setCrtdate(new Date());
            newsService.addNews(news);
        }
        return "redirect:/news/list";
    }

    @RequestMapping(value = "/delete",method = RequestMethod.POST)
    @ResponseBody
    public Result deleteNews(Long id){
        Result result= null;
        try {
            newsService.deleteNews(id);
            result = new Result(true,"");
        } catch (Exception e) {
            e.printStackTrace();
            result = new Result(false,"");
        }
        return result;
    }
}
