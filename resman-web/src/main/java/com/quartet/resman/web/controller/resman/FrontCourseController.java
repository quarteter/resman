package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.*;
import com.quartet.resman.repository.CommentDao;
import com.quartet.resman.service.Config;
import com.quartet.resman.service.CourseService;
import com.quartet.resman.service.ResCommentService;
import com.quartet.resman.service.ResCountService;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
import com.quartet.resman.utils.Constants;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by lcheng on 2015/4/24.
 */
@Controller
@RequestMapping("/front/course")
public class FrontCourseController {
    private static final int pageSize = 9;
    @Autowired
    private FolderService folderService;
    @Autowired
    private FileService fileService;
    @Autowired
    private CourseService courseService;
    @Autowired
    private ResCountService countService;
    @Autowired
    private ResCommentService commentService;
    @Autowired
    private CommentDao commentDao;
    @Autowired
    private Config config;

    @RequestMapping("/list")
    public String list(String parent, @PageableDefault(size = pageSize) Pageable page, Model model) {
//        String parentPath = null;
//        if (StringUtils.isEmpty(parent)) {
//            parentPath = Constants.REP_JPK;
//        } else {
//            Folder folder = folderService.getFolderByUUID(parent);
//            parentPath = folder.getPath();
//            model.addAttribute("parentName", folder.getName());
//        }
//        List<Folder> folders = folderService.getChildrenFolders(parentPath);
//        List<Document> files = folderService.getChildrenFiles(parentPath);

        List<Folder> folders = folderService.getChildrenFolders(Constants.REP_JPK);
        List<Document> files = new ArrayList<>();
        if (StringUtils.isNotEmpty(parent)) {
            Folder parentFolder = folderService.getFolderByUUID(parent);
            files = folderService.getChildrenFiles(parentFolder.getPath());
            model.addAttribute("parentName", parentFolder.getName());
            model.addAttribute("parentUid", parent);
        } else {
            if (folders.size() > 0) {
                Folder parentFolder = folders.get(0);
                files = folderService.getChildrenFiles(parentFolder.getPath());
                model.addAttribute("parentName", parentFolder.getName());
                model.addAttribute("parentUid", parentFolder.getUuid());
            }
        }

        model.addAttribute("folders", folders);
        model.addAttribute("files", files);
        model.addAttribute("curPage", page.getPageNumber());
        int totalSize = files.size();
        int totalPage = (totalSize % pageSize == 0) ? totalSize / pageSize : (totalSize / pageSize + 1);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("totalCount", totalSize);
        int end = (page.getPageNumber() + 1) * pageSize;
        end = end > files.size() ? (files.size() - 1) : (end - 1);
        model.addAttribute("beginIdx", page.getPageNumber() * pageSize);
        model.addAttribute("endIdx", end);

        return "front/course";
    }

    @RequestMapping(value = "/play", method = RequestMethod.GET)
    public String play(String uid, Model model) {
        if (StringUtils.isNotEmpty(uid)) {
            Document doc = fileService.getFileInfoByUUID(uid);
            if (doc != null) {
                String parentUid = fileService.getParentUid(doc.getUuid());
                DocCourse course = courseService.getDocCourseByUid(parentUid);
                model.addAttribute("doc", doc);
                model.addAttribute("videoServer", config.getVideoServer());
                String docName = doc.getName();
                int idx = docName.lastIndexOf(".");
                docName = idx != -1 ? docName.substring(0, idx) : docName;
                model.addAttribute("docName", docName);
                model.addAttribute("course", course);

//                Page<ResComment> comments = commentService.getResComments(uid,new PageRequest(0,5));
                Page<Comment> comments = commentDao.findByResourceid(uid, new PageRequest(0, 5, new Sort(Sort.Direction.DESC, "crtdate")));
                model.addAttribute("comments", comments.getContent());
                model.addAttribute("totalPage", comments.getTotalPages());

                ResCount count = countService.getResCount(uid);
                if (count != null) {
                    model.addAttribute("viewCount", count.getViewCount());
                } else {
                    model.addAttribute("viewCount", 1);
                }

                countService.addViewCount(uid);
            }
        }
        return "front/show_course";
    }

    @RequestMapping("/comments")
    @ResponseBody
    public Page<ResComment> getResComment(String uid, @PageableDefault(size = 5) Pageable page) {
        Page<ResComment> result = commentService.getResComments(uid, page);
        return result;
    }
}
