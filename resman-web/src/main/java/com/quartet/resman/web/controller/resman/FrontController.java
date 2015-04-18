package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.Info;
import com.quartet.resman.service.InfoService;
import com.quartet.resman.utils.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 前台页面控制器
 * User: qfxu
 * Date: 2015-04-17
 */
@Controller
@RequestMapping(value = "front")
public class FrontController {

    @Autowired
    private InfoService infoService;

    @RequestMapping(value = "index")
    public String index() {
        return "front/index";
    }

    @RequestMapping(value = "works")
    public String works() {
        return "front/works";
    }

    @RequestMapping(value = "news")
    public String news(@PageableDefault(size = 20, sort = "crtdate",
            direction = Sort.Direction.DESC) Pageable page, Model model) {
        Page<Info> news = infoService.getInfo(Constants.INFO_TYPE_NEWS, true, page);
        model.addAttribute("news", news.getContent());
        model.addAttribute("curPage", news.getNumber());
        model.addAttribute("totalPage", news.getTotalPages());
        model.addAttribute("totalCount", news.getTotalElements());
        return "front/news";
    }

    @RequestMapping(value = "news/{id}")
    public String newsDetail(@PathVariable(value = "id") Long id,Model model) {
        Info info = infoService.getInfoEager(id);
        model.addAttribute("news",info);
        return "front/show_news";
    }

    @RequestMapping(value = "course")
    public String course() {
        return "front/course";
    }

    @RequestMapping("teachers")
    public String teachers() {
        return "front/teachers";
    }
}
