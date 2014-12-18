package com.quartet.resman.web.controller.system;

import org.arcie.ctsm.entity.Func;
import org.arcie.ctsm.entity.Result;
import org.arcie.ctsm.service.FuncService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
@RequestMapping(value = "/sys/func")
public class FuncController {

    @Autowired
    private FuncService funcService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        return "system/func-list";
    }

    @RequestMapping(value = "/treeList", method = RequestMethod.POST)
    @ResponseBody
    public List<Map<String,Object>> funcTreeList(Long pid) {
        List<Func> data = null;
        if (pid != null) {
            data = funcService.getFuncByParent(pid);
        } else {
            data = funcService.getRootFunc();
        }
        return convertToFuncVO(data);
    }
    @RequestMapping(value = "/query", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> query(Long pid,@PageableDefault Pageable page){
        Map<String,Object> result = new HashMap<>();
        Page<Func> data = funcService.getFuncByParentAndLeaf(pid,page);
        result.put("rows",data.getContent());
        result.put("total",data.getTotalElements());
        return result;
    }
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Result addFunc(Func func){
        Result result = null;
        try{
            funcService.addFunc(func);
            result = new Result(true,"");
        }catch (Throwable t){
            result = new Result(false,"");
        }
        return result;
    }
    @RequestMapping(value = "/del", method = RequestMethod.POST)
    @ResponseBody
    public Result delFunc(Long uid){
        Result result = null;
        try{
            funcService.delFunc(uid);
            result = new Result(true,"");
        }catch (Throwable t){
            result = new Result(false,"");
        }
        return result;
    }


    private List<Map<String,Object>> convertToFuncVO(List<Func> data){
        if (data!=null){
            List<Map<String,Object>> result = new ArrayList<>();
            for (Func func:data){
                Map<String,Object> row = new HashMap<>();
                row.put("id",func.getId());
                row.put("name",func.getName()+"("+func.getSeqNo()+")");
                boolean leaf = func.isLeaf();
                row.put("isParent",!leaf);
                result.add(row);
            }
            return result;
        }
        return  new ArrayList<>();
    }
}
