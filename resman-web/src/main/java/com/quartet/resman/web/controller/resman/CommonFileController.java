package com.quartet.resman.web.controller.resman;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.quartet.resman.converter.ConverterService;
import com.quartet.resman.converter.PreviewTask;
import com.quartet.resman.entity.*;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.service.Config;
import com.quartet.resman.service.UserService;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
import com.quartet.resman.utils.FileUtils;
import com.quartet.resman.utils.Types;
import com.quartet.resman.web.vo.FileFuncDef;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.ClassUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author: lcheng
 * @date: 2015/2/24
 * @version: 1.0
 */
@Controller
@RequestMapping(value = "/res/common/{func}")
public class CommonFileController {

    @Autowired
    private UserService userService;
    @Autowired
    private FileService fileService;
    @Autowired
    private FolderService folderService;

    @Autowired
    private ConverterService converterService;

    private static Map<String, FileFuncDef> funcDefs;
    private static String FUNC_DEF_JSON = "/fm-def.json";

    static {
        ObjectMapper jsonMapper = new ObjectMapper();
        try (InputStream is = CommonFileController.class.getResourceAsStream(FUNC_DEF_JSON);) {
            funcDefs = jsonMapper.readValue(is, new TypeReference<Map<String, FileFuncDef>>() {
            });
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/list")
    public String list(@PathVariable String func, String path, Model model) {
        String decodePath = "";
        if (!StringUtils.isEmpty(path))
            decodePath = URLDecoder.decode(path);
        List<Map<String, String>> items = analyzePath(decodePath);
        FileFuncDef def = getFuncDefByName(func);
        model.addAttribute("items", items);
        model.addAttribute("path", decodePath);
        model.addAttribute("title", def.getTitle());
        model.addAttribute("func", func);
        model.addAttribute("funcDef", def);
        return "resman/common-file-list";
    }

    @RequestMapping("/query")
    @ResponseBody
    public List<Map<String, Object>> query(@PathVariable String func, String searchText, String path) {
        FileFuncDef def = getFuncDefByName(func);
        String rootPath = initRoot(def.getRootDir(), def.isRootDirPersonal());
        String queryPath = rootPath;
        if (StringUtils.isNotEmpty(path))
            queryPath += path;
        List<Entry> nodes = folderService.getChildren(queryPath);
        List<Map<String, Object>> list = new ArrayList();
        List<Map<String, Object>> fileList = new ArrayList();
        if (nodes == null || nodes.size() == 0)
            return list;
        Map<String, Object> map = null;
        for (Entry node : nodes) {
            map = new HashMap();
            map.put("uuid", node.getUuid());
            map.put("name", node.getName());
            map.put("path", node.getPath());
            map.put("modifyDate", formatDate(node.getCreated()));
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

    @RequestMapping("/addFolder")
    @ResponseBody
    public Result addFolder(@PathVariable String func, String path, String name) {
        Result result = new Result();
        ShiroUser user = userService.getCurrentUser();
        FileFuncDef def = getFuncDefByName(func);
        String rootPath = initRoot(def.getRootDir(), def.isRootDirPersonal());
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
    @RequestMapping("/rename")
    @ResponseBody
    public Result rename(@PathVariable String func, String path, String oldName, String name) {
        Result result = new Result();
        if (oldName.equals(name))
            return result;
        FileFuncDef def = getFuncDefByName(func);
//        String rootPath = initRoot(def.getRootDir(),def.isRootDirPersonal());
//        String oldPath = rootPath + path + "/" + oldName.trim();
//        String newPath = rootPath + path + "/" + name.trim();
        int slashIdx = path.lastIndexOf("/");
        String newPath = path.substring(0, slashIdx) + "/" + name;
        Folder folder = folderService.getFolder(newPath);
        if (folder != null) {
            result.setSuccess(false);
            result.setMsg("已经存在名称为：[" + name + "]的文件");
            return result;
        }

        folderService.rename(path, name);
        return result;
    }

    /**
     * 上传文件
     *
     * @param path
     * @param uploadFile
     * @return
     */
    @RequestMapping("/upload")
    @ResponseBody
    public Result upload(@PathVariable String func, String path, @RequestParam("fileData") MultipartFile uploadFile) {
        ShiroUser user = userService.getCurrentUser();
        Result result = new Result();
        FileFuncDef def = getFuncDefByName(func);
        String rootPath = initRoot(def.getRootDir(), def.isRootDirPersonal());
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
    public Result delete(@PathVariable String func, String path, String names) {
        FileFuncDef def = getFuncDefByName(func);
        String rootPath = initRoot(def.getRootDir(), def.isRootDirPersonal());
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

    @RequestMapping(value = "/moveTo", method = RequestMethod.POST)
    @ResponseBody
    public Result moveTo(String srcPath, String destPath) {
        Result result = null;
        try {
            folderService.moveTo(srcPath, destPath);
            result = new Result(true,"");
        } catch (Throwable e) {
            e.printStackTrace();
            result = new Result(false,"");
        }
        return result;
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
     * 获得通用文件管理的定义
     *
     * @param name
     * @return
     */
    private FileFuncDef getFuncDefByName(String name) {
        if (funcDefs != null) {
            return funcDefs.get(name);
        }
        throw new RuntimeException("没有找到该文件管理的功能定义!");
    }

    /**
     * 初始化跟路径
     *
     * @param rootDir
     * @param dirPersonal
     * @return
     */
    private String initRoot(String rootDir, boolean dirPersonal) {
        Folder rootFolder = folderService.getFolder(rootDir);
        ShiroUser user = userService.getCurrentUser();
        if (rootFolder == null) {
            rootFolder = new Folder(rootDir, user.getUserName(), "0", "a", Types.Folders.Generic.getValue());
            folderService.addFolder(rootFolder);
        }
        if (!dirPersonal)
            return rootFolder.getPath();
        String personalPath = rootDir + "/" + user.getUserName();
        Folder userFolder = folderService.getFolder(personalPath);
        if (userFolder == null) {
            userFolder = new Folder(rootDir, user.getUserName(), "0", "a", Types.Folders.Generic.getValue());
            folderService.addFolder(userFolder);
        }
        return userFolder.getPath();
    }

    private String formatDate(Date date) {
        if (date == null)
            return "";
        Format format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return format.format(date);
    }

}
