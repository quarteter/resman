package com.quartet.resman.web.controller.system;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.Func;
import com.quartet.resman.entity.Permission;
import com.quartet.resman.entity.Result;
import com.quartet.resman.entity.Role;
import com.quartet.resman.service.FuncService;
import com.quartet.resman.service.PermissionService;
import com.quartet.resman.service.RoleService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Controller
@RequestMapping("/sys/role")
public class RoleController {

    @Autowired
    private RoleService roleService;
    @Autowired
    private FuncService funcService;
    @Autowired
    private PermissionService permService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String roleList() {
        return "system/role-list";
    }

    @RequestMapping(value = "/query", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> loadRoles(String searchText, @PageableDefault Pageable page) {
        Map<String, Object> result = new HashMap<>();
        Page<Role> data = null;
        if (StringUtils.isNotEmpty(searchText)) {
            List<SearchFilter> filters = Lists.newArrayList();
            SearchFilter filter = new SearchFilter("name", SearchFilter.Operator.LIKE, searchText);
            filters.add(filter);
            data = roleService.getRoles(DynamicSpecifications.bySearchFilter(filters, Role.class), page);
        } else {
            data = roleService.getRoles(page);
        }
        result.put("rows", data.getContent());
        result.put("total", data.getTotalElements());
        return result;
    }

    @RequestMapping(value = "/funcTree", method = RequestMethod.POST)
    @ResponseBody
    public List<Map<String, Object>> roleFuncTree(Long rid,Long pid) {
        Set<Long> roleFuncIds = roleService.getRoleFuncIds(rid);
        List<Func> data = null;
        if (pid != null) {
            data = funcService.getFuncByParent(pid);
        } else {
            data = funcService.getRootFunc();
        }
        return convertToFuncVO(data, roleFuncIds);
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addRole() {
        return "system/role-add";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addRole(Role role) {
        roleService.addRole(role);
        return "redirect:/sys/role/list";
    }

    @RequestMapping(value = "/addFunc", method = RequestMethod.POST)
    @ResponseBody
    public Result addRoleFunc(Long uid, @RequestParam(value = "funcIds[]",required = false) Long[] funcIds) {
        Result result = null;
        Set<Long> func = (funcIds!=null) ? Sets.newHashSet(funcIds) : new HashSet<Long>() ;
        try {
            roleService.updateRoleFunc(uid, func);
            result = new Result(true, "");
        } catch (Throwable t) {
            t.printStackTrace();
            result = new Result(false, "");
        }
        return result;
    }
    @RequestMapping(value = "/addPerm", method = RequestMethod.POST)
    @ResponseBody
    public Result addRolePerm(Long uid,@RequestParam(value = "permIds[]",required = false)Long[] permIds){
        Result result = null;
        Set<Long> permSet = (permIds!=null) ? Sets.newHashSet(permIds) : new HashSet<Long>();
        try{
            roleService.updateRolePerm(uid,permSet);
            result = new Result(true, "");
        }catch (Throwable t){
            t.printStackTrace();
            result = new Result(false, "");
        }
        return result;
    }

    @RequestMapping(value = "/rolePerms", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> getRolePerm(Long uid){
//        List<Permission> unselected = roleService.getRoleNotAssignedPerm(uid);
        List<Permission> all = permService.getPermissions();
        List<Permission> selected = roleService.getRolePerm(uid);
        Map<String,Object> result = new HashMap<>(2);
//        result.put("unselected",unselected);
        result.put("all",all);
        result.put("selected",selected);
        return result;
    }

    @RequestMapping(value = "/del", method = RequestMethod.POST)
    @ResponseBody
    public Result deleteRole(String ids) {
        Result r = null;
        if (StringUtils.isNotEmpty(ids)) {
            String[] ida = ids.split(",");
            List<Long> idList = new ArrayList<>();
            for (int i = 0; i < ida.length; i++) {
                Long uid = Long.valueOf(ida[i]);
                idList.add(uid);
            }
            try {
                roleService.deleteRole(idList);
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
    public ModelAndView editRole(Long uid) {
        Role role = roleService.getRole(uid);
        ModelAndView mv = new ModelAndView("system/role-edit");
        mv.addObject("role", role);
        return mv;
    }

    @RequestMapping(value = "/validate", method = RequestMethod.POST)
    @ResponseBody
    public Boolean exist(String role) {
        List<Role> roles = roleService.getRoles(role);
        return (roles != null && roles.size() > 0) ? false : true;
    }

    @RequestMapping(value = "/validate", params = "uid", method = RequestMethod.POST)
    @ResponseBody
    public Boolean exist(Long uid, String role) {
        return roleService.roleExistExcludeSelf(uid, role) ? false : true;
    }

    private List<Map<String, Object>> convertToFuncVO(List<Func> data, Set<Long> ids) {
        if (data != null) {
            List<Map<String, Object>> result = new ArrayList<>();
            for (Func func : data) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", func.getId());
                row.put("name", func.getName() + "(" + func.getSeqNo() + ")");
                boolean leaf = func.isLeaf();
                row.put("isParent", !leaf);
                if (ids.contains(func.getId())) {
                    row.put("checked", true);
                }
                result.add(row);
            }
            return result;
        }
        return new ArrayList<>();
    }
}
