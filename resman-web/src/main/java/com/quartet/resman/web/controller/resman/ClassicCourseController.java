package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.*;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.service.UserService;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Controller
@RequestMapping(value = "/res/course/classic")
public class ClassicCourseController {

    @Autowired
    private UserService userService;
    @Autowired
    private FileService fileService;
    @Autowired
    private FolderService folderService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        return "resman/classic-list";
    }

    @RequestMapping(value = "/query", method = RequestMethod.POST)
    @ResponseBody
    public List<Entry> query(String path,String searchText) {
        return folderService.getChildren(path);
    }

    @RequestMapping(value = "/addFolder")
    @ResponseBody
    public void addFolder(Folder folder) {
        folderService.addFolder(folder);
    }

    @RequestMapping(value = "/addFile")
    @ResponseBody
    public Result addFile(String path, MultipartFile fileData) {
        ShiroUser user = userService.getCurrentUser();
        Result result = null;
        try (InputStream is = fileData.getInputStream()) {
            String fileName = fileData.getOriginalFilename();
            File file = new File(path + "/" + fileName, user.getUserName(), new FileStream(is), fileData.getSize());
            fileService.addFile(file);
            IOUtils.closeQuietly(is);
            result = new Result(true, "");
        } catch (IOException ex) {
            ex.printStackTrace();
            result = new Result(false, "");
        }
        return result;
    }
}
