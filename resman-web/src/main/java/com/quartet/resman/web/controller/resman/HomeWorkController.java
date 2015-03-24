package com.quartet.resman.web.controller.resman;


import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;

import com.quartet.resman.entity.CourseStudent;
import com.quartet.resman.repository.CourseStudentDao;
import com.quartet.resman.repository.HomeWorkVoDao;

import com.quartet.resman.service.UserService;
import com.quartet.resman.vo.HomeWorkVo;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.annotation.Resource;
import java.util.*;

/**
 * User: xwang
 * Date: 15-1-15
 */
@Controller
@RequestMapping(value = "/res/homework")
public class HomeWorkController {

    @Resource
    private UserService userService;

    @Resource
    private HomeWorkVoDao homeWorkVoDao;

    @Resource
    private CourseStudentDao courseStudentDao;

    @RequestMapping("list")
    public String list() {
        return "resman/homework-list";
    }

    @RequestMapping(value = "query", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> query(String searchText, @PageableDefault Pageable page) {
        Page<HomeWorkVo> homeworks = null;
        if (StringUtils.isNotEmpty(searchText)) {
            SearchFilter filter = new SearchFilter("name", SearchFilter.Operator.LIKE, searchText);
            List<SearchFilter> filters = new ArrayList<>(1);
            filters.add(filter);
            Specification spec = DynamicSpecifications.bySearchFilter(filters, HomeWorkVo.class);
            homeworks = homeWorkVoDao.findAll(spec, page);
        } else {
            homeworks = homeWorkVoDao.findAll(page);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("rows", homeworks.getContent());
        map.put("total", homeworks.getTotalElements());
        return map;
    }

    @RequestMapping("view/{id}")
    public String view(@PathVariable("id") Long id, Model model) {
        HomeWorkVo homework = homeWorkVoDao.findOne(id);
        if( homework == null )
            homework = new HomeWorkVo();
        model.addAttribute("homework", homework);
        return "resman/homework-view";
    }

    @RequestMapping("listScore/{id}")
    public String listscore(@PathVariable("id") Long id, Model model) {
        model.addAttribute("homeworkID", id);
        return "resman/homework-score-list";
    }


    @RequestMapping(value = "listScore/query")
    @ResponseBody
    public Map<String, Object> listScoreQuery(String homeworkID, @PageableDefault Pageable page) {
        List<CourseStudent> list = courseStudentDao.findByCourse(Long.valueOf(homeworkID));
        Map<String, Object> map = new HashMap<>();
        map.put("rows", list);
        map.put("total", list.size());
        return map;
    }

}
