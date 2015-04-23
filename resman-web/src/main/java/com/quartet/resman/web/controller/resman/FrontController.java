package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.*;
import com.quartet.resman.service.InfoService;
import com.quartet.resman.service.QuestionService;
import com.quartet.resman.service.ResCountService;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
import com.quartet.resman.utils.Constants;
import com.quartet.resman.vo.QuestionVo;
import com.quartet.resman.web.vo.FileFuncDef;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
    private ResCountService resCountService;

    @RequestMapping(value = "index")
    public String index() {
        return "front/index";
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
    public String resources(@PathVariable(value = "func") String func, String search, Model model) {
        FileFuncDef def = cfController.getFuncDefByName(func);
        String rootPath = cfController.initRoot(def.getRootDir(), def.isRootDirPersonal()) + "//";
        List<Document> nodes =  fileService.queryFile(rootPath, search, "", "");
        List<Map<String, Object>> list = new ArrayList();
        if (nodes != null && nodes.size() > 0) {
            Map<String, Object> map = null;
            for (Entry node : nodes) {
                map = new HashMap();
                map.put("uuid", node.getUuid());
                map.put("name", node.getName());
                map.put("path", node.getPath());
                map.put("modifyDate", formatDate(node.getCreated()));
                map.put("author", node.getCreateBy());
                if (!(node instanceof Document)) {
                    continue;
                }
                Document document = (Document) node;
                String size = "0";
                long docSize = document.getSize();
                if (docSize > 1073741824) {
                    size = String.format("%10.2f", docSize / 1073741824.0) + " GB";
                } else if (docSize > 1048576) {
                    size = String.format("%10.2f", docSize / 1048576.0) + " MB";
                } else {
                    size = docSize / 1024 + " KB";
                }
                map.put("type", document.getMimeType());
                map.put("size", size);

                ResCount resCount = resCountService.getResCount(node.getUuid());
                map.put("downCount", resCount.getDownCount());

                list.add(map);
            }
            model.addAttribute("resList", list);
        }
        model.addAttribute("func", func);
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
