package com.quartet.resman.web.controller.system;

import org.apache.commons.lang3.StringUtils;
import org.arcie.ctsm.entity.Permission;
import org.arcie.ctsm.entity.Result;
import org.arcie.ctsm.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
@RequestMapping("/sys/perm")
public class PermController {

    @Autowired
    private PermissionService permService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String permList() {
        return "system/perm-list";
    }

    @RequestMapping(value = "/query", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> loadPerms(@PageableDefault Pageable page) {
        Page<Permission> perms = permService.getPermissions(page);
        Map<String, Object> map = new HashMap<>();
        map.put("rows", perms.getContent());
        map.put("total", perms.getTotalElements());
        return map;
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addPerms() {
        return "system/perm-add";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addPerms(Permission perm) {
        permService.addPermission(perm);
        return "redirect:/sys/perm/list";
    }

    @RequestMapping(value = "/del", method = RequestMethod.POST)
    @ResponseBody
    public Result delPerms(String ids) {
        Result r = null;
        if (StringUtils.isNotEmpty(ids)) {
            String[] ida = ids.split(",");
            List<Long> idList = new ArrayList<>();
            for (int i = 0; i < ida.length; i++) {
                Long uid = Long.valueOf(ida[i]);
                idList.add(uid);
            }
            try {
                permService.deletePerms(idList);
                r = new Result(true, "");
            } catch (Throwable t) {
                r = new Result(false, "删除失败!");
                t.printStackTrace();
            }
        }
        r = new Result(true, "");
        return r;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView editPerm(Long uid) {
        ModelAndView mv = new ModelAndView("system/perm-edit");
        Permission perm = permService.getPermission(uid);
        mv.addObject("perm",perm);
        return mv;
    }
}
