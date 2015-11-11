package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.Document;
import com.quartet.resman.entity.Folder;
import com.quartet.resman.entity.ResCount;
import com.quartet.resman.service.ResCountService;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
import com.quartet.resman.web.vo.FileFuncDef;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 前台页面控制器
 * User: qfxu
 * Date: 2015-04-17
 */
@Controller
@RequestMapping(value = "front")
public class FrontController {

    @Autowired
    private CommonFileController cfController;

    @Autowired
    private FileService fileService;

    @Autowired
    private FolderService folderService;

    @Autowired
    private ResCountService resCountService;

    @RequestMapping(value = "index")
    public String index() {
        return "forward:./home";
    }

    @RequestMapping(value = "works")
    public String works() {
        return "front/works";
    }

    @RequestMapping(value = "course")
    public String course() {
        return "front/course";
    }

    @RequestMapping(value = "resources/{func}")
    public String resources(@PathVariable(value = "func") String func, String search, String path, @RequestParam(defaultValue = "0") int page, Model model) {
        FileFuncDef def = cfController.getFuncDefByName(func);
        String rootPath = cfController.initRoot(def.getRootDir(), def.isRootDirPersonal()) + "/";

        String queryPath = rootPath;
        if (StringUtils.isNotEmpty(path))
            queryPath += path;

        Map<String, Object> data = folderService.getChildren(queryPath, search, page * 10, 10);

        //List<Document> nodes =  fileService.queryFile(rootPath, search, "", "");
        List<Object> nodes = (List<Object>) data.get("rows");
        List<Map<String, Object>> list = new ArrayList();
        if (nodes != null && nodes.size() > 0) {
            Map<String, Object> map = null;
            for (Object node : nodes) {
                map = new HashMap();
                if (node instanceof Folder) {
                    Folder folder = (Folder) node;
                    map.put("uuid", folder.getUuid());
                    map.put("name", folder.getName());
                    map.put("path", folder.getPath());
                    String fp = folder.getPath();
                    fp = fp.replace(func, "");
                    while (fp.charAt(0) == '/') {
                        fp = fp.substring(1);
                    }
//                    fp.trim()
                    map.put("realPath", fp);

                    map.put("modifyDate", "-");
                    map.put("author", "-");
                    map.put("size", "-");
                    map.put("downCount", "-");
                    map.put("type", "目录");
                } else if (node instanceof Document) {
                    Document doc = (Document) node;
                    map.put("uuid", doc.getUuid());
                    map.put("name", doc.getName());
                    map.put("path", doc.getPath());
                    map.put("modifyDate", formatDate(doc.getCreated()));
                    map.put("author", doc.getCreateBy());
                    map.put("type", doc.getMimeType());

                    String size = "0";
                    long docSize = doc.getSize();
                    if (docSize > 1073741824) {
                        size = String.format("%10.2f", docSize / 1073741824.0) + " GB";
                    } else if (docSize > 1048576) {
                        size = String.format("%10.2f", docSize / 1048576.0) + " MB";
                    } else {
                        size = docSize / 1024 + " KB";
                    }
                    map.put("size", size);

                    ResCount resCount = resCountService.getResCount(doc.getUuid());
                    map.put("downCount", resCount.getDownCount());
                }

                list.add(map);
            }

        }

        model.addAttribute("resList", list);
        model.addAttribute("func", func);
        model.addAttribute("funcName", def.getTitle());
        model.addAttribute("search", search);
        model.addAttribute("total", data.get("total"));
        model.addAttribute("curPage", page);
        model.addAttribute("path", path);
        int total = Integer.valueOf(data.get("total").toString());
        int totalPage = 0;
        if (total > 0)
            totalPage = total / 10 + 1;
        model.addAttribute("totalPage", totalPage);
        return "front/resources";
    }

//    @RequestMapping("teachers")
//    public String teachers() {
//        return "front/teachers";
//    }


    private String formatDate(Date date) {
        if (date == null)
            return "";
        Format format = new SimpleDateFormat("yyyy-MM-dd");
        return format.format(date);
    }
}
