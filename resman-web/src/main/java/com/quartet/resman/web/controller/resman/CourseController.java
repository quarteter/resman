package com.quartet.resman.web.controller.resman;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.*;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.repository.CategoryDao;
import com.quartet.resman.repository.CourseDao;
import com.quartet.resman.repository.CourseStudentDao;
import com.quartet.resman.repository.NoticeDao;
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
import java.util.*;

/**
 * User: qfxu
 * Date: 15-1-8
 */
@Controller
@RequestMapping(value = "/res/course")
public class CourseController {

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
    public String list(String pid, Model model) {
        if (StringUtils.isEmpty(pid))
            model.addAttribute("pid", "0");
        else {
            Course course = courseDao.findOne(Long.valueOf(pid));
            model.addAttribute("pid", pid);
            model.addAttribute("name", course.getName());
        }

        return "resman/course-list";
    }

    @RequestMapping(value = "query", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> query(String searchText, String pid, @PageableDefault Pageable page) {
        Page<Course> courses = null;
        Long parent = null;
        if (!StringUtils.isEmpty(pid))
            parent = Long.valueOf(pid);
        else
            parent = 0l;
        if (StringUtils.isNotEmpty(searchText)) {
            SearchFilter filter = new SearchFilter("name", SearchFilter.Operator.LIKE, searchText);
            List<SearchFilter> filters = new ArrayList<>(1);
            filters.add(filter);
            Specification spec = DynamicSpecifications.bySearchFilter(filters, Course.class);
            courses = courseDao.findByParent(parent, spec, page);
        } else {
            courses = courseDao.findByParent(parent, page);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("rows", courses.getContent());
        map.put("total", courses.getTotalElements());
        return map;
    }

    @RequestMapping("add")
    public String add(String pid, Model model) {
        List<Category> categories = categoryDao.findAll();
        if (StringUtils.isEmpty(pid))
            pid = "0";
        model.addAttribute("pid", pid);
        if (pid.equals("0")) {
            model.addAttribute("categories", categories);
            return "resman/course-add";
        } else {
            return "resman/job-add";
        }
    }

    @RequestMapping("edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model) {
        Course course = courseDao.findOne(id);
        String ntype = course.getNtype();
        if (StringUtils.isNotEmpty(ntype) && ntype.equals("0")) {
            List<Category> categories = categoryDao.findAll();
            model.addAttribute("course", course);
            model.addAttribute("categories", categories);
            return "resman/course-edit";
        } else {
            model.addAttribute("job", course);
            return "resman/job-edit";
        }
    }

    @RequestMapping("save")
    @ResponseBody
    public Result save(Course vo) {
        Result result = new Result();
        Long id = vo.getId();
        Course course = null;
        if (id == null) {
            course = new Course();
            String ntype = vo.getNtype();
            course.setNtype(ntype);
            if (ntype.equals("0"))
                course.setParent(0L);
            else
                course.setParent(vo.getParent());
        } else {
            course = courseDao.getOne(id);
        }
        course.setName(vo.getName());
        course.setDescription(vo.getDescription());
        Category categoryVO = vo.getCategory();
        if (categoryVO != null) {
            Long categoryId = categoryVO.getId();
            Category category = categoryDao.getOne(categoryId);
            course.setCategory(category);
        }

        courseDao.save(course);
        return result;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(String ids) {
        Result r = new Result();
        if (StringUtils.isNotEmpty(ids)) {
            String[] ida = ids.split(",");
            try {
                for (String id : ida) {
                    List<Course> children = courseDao.findByParent(Long.valueOf(id));
                    if (children != null && children.size() > 0) {
                        courseDao.delete(children);
                    }
                    courseDao.delete(Long.valueOf(id));
                }
            } catch (Throwable t) {
                r.setSuccess(false);
                r.setMsg("删除失败！");
                t.printStackTrace();
            }
        }
        return r;
    }

    /**
     * 上传作业
     *
     * @param uploadFile
     * @return
     */
    @RequestMapping("upload")
    @ResponseBody
    public Result upload(String courseId, @RequestParam("fileData") MultipartFile uploadFile) {
        Result result = new Result();
        ShiroUser user = userService.getCurrentUser();
        String rootPath = "/course_" + courseId;
        Folder rootFolder = folderService.getFolder(rootPath);
        if (rootFolder == null) {
            rootFolder = new Folder(rootPath, "system", "0", "a", Types.Folders.Generic.getValue());
            folderService.addFolder(rootFolder);
        }

        String fileName = uploadFile.getOriginalFilename();
        String mimeType = FileUtils.getFileExtension(fileName).toLowerCase();
        String filePath = rootPath + "/" + fileName;

        //清除之前上传的作业
        List<CourseStudent> list = courseStudentDao.findByUserAndCourse(user.getId(), Long.valueOf(courseId));
        if (list != null && list.size() > 0) {
            for (CourseStudent cs : list) {
                String path = cs.getPath();
                Document oldDoc = fileService.getFileInfoByUUID(path);
                if (oldDoc != null) {
                    fileService.deleteFile(oldDoc.getPath());
                }
                courseStudentDao.delete(cs);
            }
        }

        Document doc = null;
        try {
            InputStream in = uploadFile.getInputStream();
            doc = new Document(filePath + fileName, user.getUserName(), new FileStream(in), uploadFile.getSize());
            doc.setMimeType(mimeType);
            fileService.addFile(doc);
            IOUtils.closeQuietly(in);

        } catch (Exception ex) {
            ex.printStackTrace();
            result.setSuccess(false);
            result.setMsg("文件上传失败");
        }

        if (doc != null) {
            CourseStudent courseStudent = new CourseStudent();
            courseStudent.setPath(doc.getUuid());
            courseStudent.setName(doc.getName());
            User student = new User();
            student.setId(user.getId());
            courseStudent.setUser(student);
            Course course = new Course();
            course.setId(Long.valueOf(courseId));
            courseStudent.setCourse(course);
            courseStudentDao.save(courseStudent);
        }

        return result;
    }

    @RequestMapping("score")
    public String score(String courseId, Model model){
        model.addAttribute("courseId", courseId);
        return "resman/score-list";
    }
}
