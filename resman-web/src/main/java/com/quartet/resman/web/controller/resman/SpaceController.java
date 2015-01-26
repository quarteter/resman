package com.quartet.resman.web.controller.resman;

import com.quartet.resman.converter.ConverterService;
import com.quartet.resman.entity.*;
import com.quartet.resman.entity.Document;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.service.Config;
import com.quartet.resman.converter.PreviewTask;
import com.quartet.resman.service.UserService;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
import com.quartet.resman.utils.FileUtils;
import com.quartet.resman.utils.Types;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.*;
import java.net.URLDecoder;
import java.text.*;
import java.util.*;

/**
 * User: qfxu
 * Date: 15-1-8
 */
@Controller
@RequestMapping(value = "/res/space")
public class SpaceController {

    private static String SWF_EXT = ".swf";
    @Resource
    private FolderService folderService;

    @Resource
    private FileService fileService;

    @Resource
    private UserService userService;

    @Resource
    private Config paramService;

    @Resource
    private ConverterService converterService;

    /**
     * 个人空间列表页面
     *
     * @param path
     * @param model
     * @return
     */
    @RequestMapping("list")
    public String list(String path, Model model) {
        String decodePath = "";
        if (!StringUtils.isEmpty(path))
            decodePath = URLDecoder.decode(path);
        List<Map<String, String>> items = analyzePath(decodePath);
        model.addAttribute("items", items);
        model.addAttribute("path", decodePath);
        return "resman/space-list";
    }

    /**
     * 分析路径
     *
     * @param path
     * @return
     */
    private List<Map<String, String>> analyzePath(String path) {
        List<Map<String, String>> rs = new ArrayList<Map<String, String>>();
        Map<String, String> map = new HashMap<String, String>();
        if (StringUtils.isEmpty(path)) {
            map = new HashMap<String, String>();
            map.put("title", "全部文件");
            map.put("path", "");
            rs.add(map);
            return rs;
        }

        map = new HashMap<String, String>();
        map.put("title", "全部文件");
        map.put("path", "");
        rs.add(map);

        String[] strs = path.split("/");
        String parentPath = "";
        for (String str : strs) {
            if (StringUtils.isEmpty(str))
                continue;
            map = new HashMap<String, String>();
            parentPath = parentPath + "/" + str;
            map.put("title", str);
            map.put("path", parentPath);
            rs.add(map);
        }
        return rs;
    }

    /**
     * 返回结果数据
     *
     * @param searchText
     * @param path
     * @return
     * @throws Exception
     */
    @RequestMapping("query")
    @ResponseBody
    public List<Map<String, String>> query(String searchText, String path) throws Exception {
        String rootPath = initRoot();
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
            map.put("modifyDate", formateDate(node.getCreated()));
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

    private String formateDate(Date date) {
        if (date == null)
            return "";
        Format format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return format.format(date);
    }

    /**
     * 保存文件夹
     *
     * @param path
     * @param name
     * @return
     */
    @RequestMapping("saveFolder")
    @ResponseBody
    public Result saveFolder(String path, String name) {
        Result result = new Result();
        ShiroUser user = userService.getCurrentUser();
        String rootPath = initRoot();
        String newPath = "";
        if (StringUtils.isEmpty(path))
            newPath = rootPath + "/" + name.trim();
        else
            newPath = rootPath + path.trim() + "/" + name.trim();
        Folder folder = folderService.getFolder(newPath);
        if (folder != null) {
            result.setSuccess(false);
            result.setMsg("文件夹已经存在");
            return result;
        }

        folder = new Folder(newPath, user.getUserName(), "0", "a", Types.Folders.Generic.getValue());
        try {
            folderService.addFolder(folder);
        } catch (Exception ex) {
            result.setSuccess(false);
            result.setMsg("新建文件夹失败");
            ex.printStackTrace();
        }
        return result;
    }

    /**
     * 重命名文件夹
     *
     * @param path
     * @param oldName
     * @param name
     * @return
     */
    @RequestMapping("rename")
    @ResponseBody
    public Result rename(String path, String oldName, String name) {
        Result result = new Result();
        if (oldName.equals(name))
            return result;
        String rootPath = initRoot();
        String oldPath = rootPath + path + "/" + oldName.trim();
        String newPath = rootPath + path + "/" + name.trim();
        Folder folder = folderService.getFolder(newPath);
        if (folder != null) {
            result.setSuccess(false);
            result.setMsg("已经存在名称为：[" + name + "]的文件");
            return result;
        }

        folderService.rename(oldPath, name);
        return result;
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

    /**
     * 上传文件
     *
     * @param path
     * @param uploadFile
     * @return
     */
    @RequestMapping("upload")
    @ResponseBody
    public Result upload(String path, @RequestParam("fileData") MultipartFile uploadFile) {
        ShiroUser user = userService.getCurrentUser();
        Result result = new Result();
        String rootPath = initRoot();
        String fileName = uploadFile.getOriginalFilename();
        String mimeType = FileUtils.getFileExtension(fileName).toLowerCase();
        String filePath = rootPath + path + "/";
        if (StringUtils.isEmpty(path))
            filePath = rootPath + "/";
        InputStream in = null;
        Document doc = null;
        try {
            in = uploadFile.getInputStream();
            doc = new Document(filePath + fileName, user.getUserName(), new FileStream(in), uploadFile.getSize());
            doc.setMimeType(mimeType);
            fileService.addFile(doc);
            IOUtils.closeQuietly(in);

            PreviewTask task = new PreviewTask(doc.getUuid(), converterService);
            task.start();

        } catch (Exception ex) {
            ex.printStackTrace();
            result.setSuccess(false);
            result.setMsg("文件上传失败");
        }

        return result;
    }


    /**
     * 删除文件
     *
     * @param path
     * @param names
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(String path, String names) {
        String rootPath = initRoot();
        Result r = new Result();
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
            } catch (Throwable t) {
                r.setSuccess(false);
                r.setMsg("删除失败！");
                t.printStackTrace();
            }
        }
        return r;
    }

}
