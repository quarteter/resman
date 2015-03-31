package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.Info;
import com.quartet.resman.entity.Result;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.service.InfoService;
import com.quartet.resman.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;

/**
 * Created by Administrator on 2015/3/25.
 */
@Controller
@RequestMapping("/info")
public class InfoController {

    //private static Map<String,String> infoTypes = new HashMap<>();

    @Autowired
    private InfoService newsService;
    @Autowired
    private UserService userService;

    @RequestMapping("/list")
    public ModelAndView list(@RequestParam(required = false) String type,
                             @PageableDefault(sort = {"crtdate"}, direction = Sort.Direction.DESC) Pageable page) {
        ModelAndView mv = new ModelAndView("resman/info-list");
        Page<Info> data = null;
        if (type!=null){
            data = newsService.getInfo(Info.Type.valueOf(type),page);
            mv.addObject("infoType",type);
        }else{
            data = newsService.getInfo(page);
        }
        mv.addObject("news", data.getContent());
        mv.addObject("totalPages", data.getTotalPages());
        mv.addObject("curPage", data.getNumber());
        return mv;
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addNews() {
        return "resman/info-add";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addNews(Info news) {
        if (news != null) {
            ShiroUser user = userService.getCurrentUser();
            String userName = user.getUserName();
            news.setCrtuser(userName);
            news.setCrtdate(new Date());
            newsService.addInfo(news);
        }
        return "redirect:/news/list";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result deleteNews(Long id) {
        Result result = null;
        try {
            newsService.deleteInfo(id);
            result = new Result(true, "");
        } catch (Exception e) {
            e.printStackTrace();
            result = new Result(false, "");
        }
        return result;
    }
}
