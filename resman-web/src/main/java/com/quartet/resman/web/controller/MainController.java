package com.quartet.resman.web.controller;

import com.quartet.resman.entity.Func;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Controller
public class MainController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/main")
    public String main() {
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Func func = userService.getSysUserFirstFunc(user.getId());
        if (func != null) {
            return "redirect:" + func.getUrl();
        } else {
            return null;
        }
    }

    @RequestMapping(value = "/login")
    public String login() {
        return "login";
    }
}
