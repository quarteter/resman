package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.Document;
import com.quartet.resman.entity.Entry;
import com.quartet.resman.entity.Folder;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
import com.quartet.resman.utils.Constants;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * Created by lcheng on 2015/4/24.
 */
@Controller
@RequestMapping("/front/course")
public class FrontCourseController {
    @Autowired
    private FolderService folderService;
    @Autowired
    private FileService fileService;

    @RequestMapping("/list")
    public String list(String parent,@PageableDefault(size =10) Pageable page,Model model) {
        String parentPath = null;
        if (StringUtils.isEmpty(parent)) {
            parentPath = Constants.REP_JPK;
        } else {
            Folder folder = folderService.getFolderByUUID(parent);
            parentPath = folder.getPath();
            model.addAttribute("parentName",folder.getName());
        }
        List<Folder> folders = folderService.getChildrenFolders(parentPath);
        List<Document> files = folderService.getChildrenFiles(parentPath);
        model.addAttribute("folders", folders);
        model.addAttribute("files", files);
        model.addAttribute("curPage",page.getPageNumber());
        int totalSize = files.size();
        int totalPage = totalSize % 10 ==0 ? totalSize /10 : (totalSize /10 + 1);
        model.addAttribute("totalPage",totalPage);
        model.addAttribute("totalCount",totalSize);
        return "front/course";
    }
}
