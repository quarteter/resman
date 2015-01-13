package com.quartet.resman.web.controller.resman;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.Entry;
import com.quartet.resman.entity.Notice;
import com.quartet.resman.entity.Result;
import com.quartet.resman.repository.NoticeDao;
import com.quartet.resman.store.FolderService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
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

    @RequestMapping("list")
    public String list() {
        return "resman/space-list";
    }

    @RequestMapping("query")
    @ResponseBody
    public List<Map<String, String>> query(String searchText){
        List<Entry> nodes = folderService.getChildren("/personal/zs");
        List<Map<String, String>>  list = new ArrayList<Map<String, String>>();
        Map<String, String> map = null;
        for(int i = 0 ; i < 10; i++){
            map = new HashMap<String , String>();
            map.put("name", "name"+i);
            map.put("size", i + "kb");
            map.put("modifyDate", "2015-01-12");
            map.put("type", "0");
            list.add(map);
        }

        for(int i = 20 ; i < 30; i++){
            map = new HashMap<String , String>();
            map.put("name", "name"+i);
            map.put("size", i + "kb");
            map.put("modifyDate", "2015-01-12");
            map.put("type", "1");
            list.add(map);
        }
        return list;
    }
}
