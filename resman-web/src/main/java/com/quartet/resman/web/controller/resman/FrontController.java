package com.quartet.resman.web.controller.resman;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 前台页面控制器
 * User: qfxu
 * Date: 2015-04-17
 */
@Controller
@RequestMapping(value = "front")
public class FrontController {

    @RequestMapping(value = "index")
    public String index(){
        return "front/index";
    }

    @RequestMapping(value = "works")
    public String works(){
        return "front/works";
    }

    @RequestMapping(value = "news")
    public String news(){
        return "front/news";
    }

    @RequestMapping(value = "course")
    public String course(){
        return "front/course";
    }

    @RequestMapping("teachers")
    public String teachers(){
        return "front/teachers";
    }
}
