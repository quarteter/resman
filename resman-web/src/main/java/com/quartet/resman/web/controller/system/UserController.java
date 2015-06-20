package com.quartet.resman.web.controller.system;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.Result;
import com.quartet.resman.entity.Role;
import com.quartet.resman.entity.SysUser;
import com.quartet.resman.entity.User;
import com.quartet.resman.excel.ExcelDataParser;
import com.quartet.resman.excel.UserDataParser;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.service.RoleService;
import com.quartet.resman.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
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
@RequestMapping("/sys/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView userList(@PageableDefault Pageable page) {
        ModelAndView mv = new ModelAndView("system/user-list");
        Page<User> users = userService.getUser(page);
        mv.addObject("users", users);
        mv.addObject("totalPages", users.getTotalPages());
        return mv;
    }

    @RequestMapping(value="/info",method = RequestMethod.GET)
    public ModelAndView userInfo(){
        ModelAndView mv = new ModelAndView("");
        ShiroUser shiroUser = userService.getCurrentUser();
        if(shiroUser!=null){
            User user = userService.getUser(shiroUser.getId());
            mv.addObject("user",user);
        }
        return mv;
    }

    @RequestMapping(value = "/query", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> loadUsers(String searchText, @PageableDefault Pageable page) {
        Page<User> users = null;
        if (StringUtils.isNotEmpty(searchText)) {
            SearchFilter filter = new SearchFilter("name", SearchFilter.Operator.LIKE, searchText);
            List<SearchFilter> filters = new ArrayList<>(1);
            filters.add(filter);
            Specification spec = DynamicSpecifications.bySearchFilter(filters, User.class);
            users = userService.getUser(spec, page);
        } else {
            users = userService.getUser(page);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("rows", users.getContent());
        map.put("total", users.getTotalElements());
        return map;
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public ModelAndView addUser() {
        ModelAndView mv = new ModelAndView("system/user-add");
        return mv;
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addUser(User user, SysUser sysUser) {
        if (sysUser != null) {
            userService.addSysUser(sysUser, user);
        }
        return "redirect:/sys/user/list";
    }

    @RequestMapping(value = "/check", method = RequestMethod.POST)
    @ResponseBody
    public Result checkSysUser(String sysName) {
        Result r = null;
        try {
            boolean exist = userService.sysUserNameExist(sysName);
            String msg = exist ? "true" : "false";
            r = new Result(true, msg);
        } catch (Throwable e) {
            r = new Result(false, "");
        }
        return r;
    }

    @RequestMapping(value = "/check", params = "sysUid", method = RequestMethod.POST)
    @ResponseBody
    public Result checkSysUser(Long sysUid, String sysName) {
        Result r = null;
        try {
            boolean exist = userService.sysUserNameExist(sysUid, sysName);
            String msg = exist ? "true" : "false";
            r = new Result(true, msg);
        } catch (Throwable e) {
            r = new Result(false, "");
        }
        return r;
    }

    @RequestMapping(value = "/del", method = RequestMethod.POST)
    @ResponseBody
    public Result delUser(String ids) {
        Result r = null;
        if (StringUtils.isNotEmpty(ids)) {
            String[] ida = ids.split(",");
            List<Long> idList = new ArrayList<>();
            for (int i = 0; i < ida.length; i++) {
                Long uid = Long.valueOf(ida[i]);
                idList.add(uid);
            }
            try {
                userService.deleteUser(idList);
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
    public ModelAndView editUser(Long uid) {
        ModelAndView mv = new ModelAndView("system/user-edit");
        User user = userService.getUser(uid);
        SysUser sysUser = userService.getSysUser(uid);
        mv.addObject("user", user);
        mv.addObject("sysUser", sysUser);
        return mv;
    }

    @RequestMapping(value = "/userRole", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> userRole(Long uid) {
        Map<String, Object> result = new HashMap<>(2);
        List<Role> all = roleService.getRoles();
        List<Long> selected = userService.getUserRole(uid);
        result.put("all", all);
        result.put("selected", selected);
        return result;
    }

    @RequestMapping(value = "/addRole", method = RequestMethod.POST)
    @ResponseBody
    public Result addUserRole(Long uid, @RequestParam(required = false, value = "roleIds[]") Long[] roleIds) {
        Result r = null;
        roleIds = (roleIds != null) ? roleIds : new Long[0];
        try {
            userService.updateUserRole(uid, roleIds);
            r = new Result(true, "");
        } catch (Throwable t) {
            t.printStackTrace();
            r = new Result(false, "");
        }
        return r;
    }

    @RequestMapping(value = "/import", method = RequestMethod.GET)
    public String importUserData(){
        return "system/user-import";
    }

    @RequestMapping(value = "/import", method = RequestMethod.POST)
    public String importUserData(String userType,MultipartFile file){
        ExcelDataParser<User> parser = new UserDataParser(userType);
        try{
            List<User> users = parser.parseData(file.getInputStream());
            userService.addDefaultUser(users);
        }catch (IOException e){
            e.printStackTrace();
        }
        return "redirect:/sys/user/list";
    }

    @RequestMapping(value="/tempFile")
    public void tempFileDownload(String type,HttpServletRequest request,HttpServletResponse response){
        String rootPath = request.getSession().getServletContext().getRealPath("/WEB-INF");
        String filePath = "",fileName ="";
        if (type.equals("student")){
            fileName ="学生_模板.xlsx";
            filePath = "/doc/学生_模板.xlsx";
        }else if (type.equals("teacher")){
            fileName ="老师_模板.xlsx";
            filePath = "/doc/老师_模板.xlsx";
        }
        String tempFilePath = rootPath+filePath;
        try {
            response.reset();
            fileName = new String(fileName.getBytes(),"ISO8859-1");
            response.addHeader("Content-Disposition","attachment; filename="+fileName );
            response.setContentType("application/octet-stream");
            FileInputStream fis = new FileInputStream(new File(tempFilePath));
            int fileSize = 1024;
            byte[] buffer = new byte[fileSize];
            int read = -1;
            OutputStream os = response.getOutputStream();
            while((read = fis.read(buffer))>0){
                os.write(buffer,0,read);
                os.flush();
            }
            fis.close();
        }catch (IOException e){
            e.printStackTrace();
        }
    }
}
