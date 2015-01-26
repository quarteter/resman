package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.*;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.service.Config;
import com.quartet.resman.service.UserService;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
import com.quartet.resman.utils.Constants;
import com.quartet.resman.utils.Types;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    @Autowired
    private Config paramService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        return "resman/classic-list";
    }

    @RequestMapping(value = "/query", method = RequestMethod.POST)
    @ResponseBody
    public List<Map<String, String>> query(String searchText, String path) {
        String rootPath = checkAndGetRoot();
        String queryPath = rootPath;
        if (StringUtils.isNotEmpty(path))
            queryPath += path;
        List<Entry> nodes = folderService.getChildren(queryPath);
        List<Map<String, String>> list = new ArrayList<Map<String, String>>();
        List<Map<String, String>> fileList = new ArrayList<Map<String, String>>();
        if (nodes == null || nodes.size() == 0)
            return list;
        Map<String, String> map = null;
        for (Entry node : nodes) {
            map = new HashMap<String, String>();
            map.put("uuid", node.getUuid());
            map.put("name", node.getName());
            map.put("modifyDate", DateFormatUtils.format(node.getCreated(), Constants.FORMAT_DATE));
            if (node instanceof Folder) {
                map.put("type", "0");
                list.add(map);
            } else {
                Document document = (Document) node;
                String size = String.valueOf(document.getSize() / 1024) + "KB";
                map.put("type", "1");
                map.put("size", size);
                fileList.add(map);
            }
        }
        list.addAll(fileList);
        return list;
    }

    @RequestMapping(value = "/addFolder")
    @ResponseBody
    public Result addFolder(Folder folder) {
        ShiroUser user = userService.getCurrentUser();
        folder.setCreateBy(user.getUserName());
        Result result = null;
        try {
            folderService.addFolder(folder);
        } catch (Throwable ex) {
            ex.printStackTrace();
            result = new Result(false, "");
        }
        return result;

    }

    @RequestMapping(value = "/addFile")
    @ResponseBody
    public Result addFile(String path, MultipartFile fileData) {
        ShiroUser user = userService.getCurrentUser();
        Result result = null;
        try (InputStream is = fileData.getInputStream()) {
            String fileName = fileData.getOriginalFilename();
            Document document = new Document(path + "/" + fileName, user.getUserName(), new FileStream(is), fileData.getSize());
            fileService.addFile(document);
            IOUtils.closeQuietly(is);
            result = new Result(true, "");
        } catch (IOException ex) {
            ex.printStackTrace();
            result = new Result(false, "");
        }
        return result;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(String path, String names) {
        Result result = null;
        String rootPath = checkAndGetRoot();
        if (StringUtils.isNotEmpty(names)) {
            String[] nameArray = names.split(",");
            try {
                for (String name : nameArray) {
                    String filePath = rootPath;
                    if (StringUtils.isEmpty(path))
                        filePath = filePath + "/" + name;
                    else
                        filePath = filePath + path + "/" + name;
                    folderService.deleteFolder(filePath);
                }
                result = new Result(true, "");
            } catch (Throwable t) {
                result = new Result(false, "删除失败!");
                t.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 下载文件
     *
     * @param name
     * @param response
     * @throws Exception
     */
    @RequestMapping("/download")
    public void download(String path, String name, HttpServletResponse response) throws Exception {
        String rootPath = checkAndGetRoot();
        String filePath = rootPath + path + "/" + name;
        if (StringUtils.isEmpty(path))
            filePath = rootPath + "/" + name;
        InputStream in = fileService.readFile(filePath);
        if (in == null)
            return;

        response.reset();
        response.setContentType("application/x-download");
        response.setCharacterEncoding("UTF-8");
        String fileDisplay = URLEncoder.encode(name, "UTF-8");
        response.addHeader("Content-Disposition", "attachment;filename=" + fileDisplay);
        // 输出资源内容到相应对象
        byte[] b = new byte[1024];
        int len;
        OutputStream out = response.getOutputStream();
        while ((len = in.read(b, 0, 1024)) != -1) {
            out.write(b, 0, len);
        }
        IOUtils.closeQuietly(in);
        IOUtils.closeQuietly(out);
    }

    private String checkAndGetRoot() {
        ShiroUser user = userService.getCurrentUser();
        if (user == null) {
            return null;
        }
        String ccRoot = paramService.getFolderClassicCourse();
        Folder rootFolder = folderService.getFolder(ccRoot);
        if (rootFolder == null) {
            rootFolder = new Folder(ccRoot, user.getUserName(), Types.Status.UnReviewed.getValue(),
                    Types.Visibility.All.getValue(), Types.Folders.ClassicCourse.getValue());
            folderService.addFolder(rootFolder);
        }
        return rootFolder.getPath();
    }
}
