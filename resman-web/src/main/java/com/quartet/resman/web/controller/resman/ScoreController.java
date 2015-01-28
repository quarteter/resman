package com.quartet.resman.web.controller.resman;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.*;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.repository.CategoryDao;
import com.quartet.resman.repository.CourseDao;
import com.quartet.resman.repository.CourseStudentDao;
import com.quartet.resman.service.UserService;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
import com.quartet.resman.utils.FileUtils;
import com.quartet.resman.utils.Types;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: qfxu
 * Date: 15-1-8
 */
@Controller
@RequestMapping(value = "/res/score")
public class ScoreController {

    @Resource
    private CategoryDao categoryDao;

    @Resource
    private CourseDao courseDao;

    @Resource
    private CourseStudentDao courseStudentDao;

    @Resource
    private UserService userService;

    @Resource
    private FileService fileService;

    @Resource
    private FolderService folderService;

    @RequestMapping("list")
    public String list(String courseId, Model model) {
        model.addAttribute("courseId", courseId);
        return "resman/score-list";
    }

    @RequestMapping(value = "query")
    @ResponseBody
    public Map<String, Object> query(String courseId, @PageableDefault Pageable page) {
        List<CourseStudent> list = courseStudentDao.findByCourse(Long.valueOf(courseId));
        Map<String, Object> map = new HashMap<>();
        List<Map<String,Object>> data = new ArrayList<>();
        Map<String,Object> row = new HashMap();
        row.put("name","lcheng");
        row.put("score",80);
        data.add(row);
        map.put("rows", data);
        map.put("total", list.size());
        return map;
    }

    @RequestMapping("saveScore")
    @ResponseBody
    public Result saveScore(CourseStudent vo) {
        CourseStudent cs = courseStudentDao.getOne(vo.getId());
        cs.setScore(vo.getScore());
        courseStudentDao.save(cs);
        return new Result();
    }
}
