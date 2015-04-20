package com.quartet.resman.web.controller.system;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.Code;
import com.quartet.resman.entity.Result;
import com.quartet.resman.service.CodeService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lcheng on 2015/4/20.
 */
@Controller
@RequestMapping("/sys/code")
public class CodeController {

    @Autowired
    private CodeService codeService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        return "system/code-list";
    }

    @RequestMapping(value = "/query", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> query(String searchText, @PageableDefault(sort = "seqNo") Pageable page) {
        Page<Code> codes = null;
        Map<String, Object> map = new HashMap<>();
        if (StringUtils.isNotEmpty(searchText)) {
            SearchFilter filter = new SearchFilter("name", SearchFilter.Operator.LIKE, searchText);
            List<SearchFilter> filters = new ArrayList<>(1);
            filters.add(filter);
            Specification<Code> spec = DynamicSpecifications.bySearchFilter(filters, Code.class);
            codes = codeService.getCode(spec, page);
        } else {
            codes = codeService.getCode(page);
        }
        map.put("rows", codes.getContent());
        map.put("total", codes.getTotalElements());
        return map;
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addCode(){
       return "system/code-add";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addCode(Code code){
        Result r = null;
        codeService.addCode(code);
        return "redirect:/sys/code/list";
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String editCode(Long uid,Model model){
        Code code = codeService.getCode(uid);
        model.addAttribute("code",code);
        return "system/code-edit";
    }

    @RequestMapping(value = "/del", method = RequestMethod.POST)
    @ResponseBody
    public Result deleteCode(String ids){
        Result r = null;
        if (StringUtils.isNotEmpty(ids)) {
            String[] ida = ids.split(",");
            List<Long> idList = new ArrayList<>();
            for (int i = 0; i < ida.length; i++) {
                Long uid = Long.valueOf(ida[i]);
                idList.add(uid);
            }
            try {
                codeService.deleteCode(idList);
                r = new Result(true, "");
            } catch (Throwable t) {
                r = new Result(false, "删除失败!");
                t.printStackTrace();
            }
        }
        r = new Result(true, "");
        return r;
    }

}
