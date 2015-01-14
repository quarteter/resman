package com.quartet.resman.web.controller.resman;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.*;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.repository.NoticeDao;
import com.quartet.resman.service.ParamServcie;
import com.quartet.resman.service.UserService;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
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
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

/**
 * User: qfxu
 * Date: 15-1-8
 */
@Controller
@RequestMapping(value = "/res/space")
public class SpaceController {

    @Resource
    private FolderService folderService;

    @Resource
    private FileService fileService;

    @Resource
    private UserService userService;

    @Resource
    private ParamServcie paramService;

    @RequestMapping("list")
    public String list() {
        return "resman/space-list";
    }

    @RequestMapping("saveFolder")
    @ResponseBody
    public Result saveFolder(String path, String name) {
        Result result = new Result();
        ShiroUser user = userService.getCurrentUser();
        String rootPath = initRoot();
        String newPath = rootPath + "/" + name;
        Folder folder = folderService.getFolder(newPath);
        if (folder != null) {
            result.setSuccess(false);
            result.setMsg("文件夹已经存在");
            return result;
        }

        folder = new Folder(rootPath + "/" + name, user.getUserName(), "0", "a", Types.Folders.Generic.getValue());
        folderService.addFolder(folder);
        return result;
    }

    @RequestMapping("query")
    @ResponseBody
    public List<Map<String, String>> query(String searchText) {

        String rootPath = initRoot();
        List<Entry> nodes = folderService.getChildren(rootPath);
        List<Map<String, String>> list = new ArrayList<Map<String, String>>();
        if (nodes == null || nodes.size() == 0)
            return list;
        Map<String, String> map = null;
        for (Entry node : nodes) {
            map = new HashMap<String, String>();
            map.put("name", node.getName());
            map.put("modifyDate", node.getCreated().toString());
            if (node instanceof Folder) {
                map.put("type", "0");
            } else {
                File file = (File)node;
                String size = String.valueOf(file.getSize() / 1024) + "KB";
                map.put("type", "1");
                map.put("size", size);
            }
            list.add(map);
        }
        return list;
    }

    /**
     * 初始化根目录
     */
    private String initRoot() {
        ShiroUser user = userService.getCurrentUser();
        if (user == null)
            return null;
        String root = paramService.getFolderPersonal();
        Folder rootFolder = folderService.getFolder(root);
        if (rootFolder == null) {
            rootFolder = new Folder(root, user.getUserName(), "0", "a", Types.Folders.Generic.getValue());
            folderService.addFolder(rootFolder);
        }

        String path = root + "/" + user.getUserName();
        Folder personalFolder = folderService.getFolder(path);
        if (personalFolder == null) {
            personalFolder = new Folder(path, user.getUserName(), "0", "a", Types.Folders.Generic.getValue());
            folderService.addFolder(personalFolder);
        }
        return personalFolder.getPath();
    }

    @RequestMapping("upload")
    @ResponseBody
    public Result upload(@RequestParam("path")String path, @RequestParam("fileData") MultipartFile uploadFile) {
        ShiroUser user = userService.getCurrentUser();
        Result result = new Result();
        InputStream in = null;
        try {
            in = uploadFile.getInputStream();
            String rootPath = initRoot();
            String fileName = uploadFile.getOriginalFilename();
            File file = new File(rootPath + "/" + fileName, user.getUserName(), new FileStream(in), uploadFile.getSize());
            fileService.addFile(file);
            IOUtils.closeQuietly(in);
        } catch (IOException ex) {
            ex.printStackTrace();
            result.setSuccess(false);
            result.setMsg("文件上传失败");
        }
        return new Result();
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(String ids) {
        String rootPath = initRoot();
        Result r = new Result();
        if (StringUtils.isNotEmpty(ids)) {
            String[] ida = ids.split(",");
            List<String> idList = new ArrayList<String>();
            for (int i = 0; i < ida.length; i++) {
                idList.add(ida[i]);
            }
            try {
                for (String id : idList)  {
                    String path = rootPath + "/" + id;
                    folderService.deleteFolder(path);
                }
            } catch (Throwable t) {
                r.setSuccess(false);
                r.setMsg("删除失败！");
                t.printStackTrace();
            }
        }
        return r;
    }
}
