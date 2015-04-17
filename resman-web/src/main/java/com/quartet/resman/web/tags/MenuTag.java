package com.quartet.resman.web.tags;

import com.quartet.resman.entity.Func;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.service.UserService;
import com.quartet.resman.utils.SysUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class MenuTag extends SimpleTagSupport {

    @Override
    public void doTag() throws JspException, IOException {
        super.doTag();
        Subject subject = SecurityUtils.getSubject();
        ShiroUser shiroUser = (ShiroUser) subject.getPrincipal();
        List<Func> funcs = SysUtils.getBean("userService", UserService.class)
                .getSysUserFunc(shiroUser.getId());
//        List<Func> funcs = SysUtils.getBean("userService", UserService.class)
//                .getSysUserFunc(5L);
        List<FuncVo> vos = denormalize(funcs);
        StringBuilder sb = new StringBuilder();
        sb.append("<ul class='sidebar-menu'>");
        generateMenu(sb,vos);
        sb.append("</ul>");
        getJspContext().getOut().write(sb.toString());
    }

    private void generateMenu(StringBuilder sb, List<FuncVo> vos) {
        for (FuncVo vo : vos) {
            int childSize = vo.getChildren().size();
            if (childSize>0){
                sb.append("<li class='treeview'>");
            }else{
                sb.append("<li>");
            }
            sb.append("<a href='");
            if (vo.getUrl()!=null){
                sb.append(vo.getUrl() + "'>");
            }else{
                sb.append("#'>");
            }
            String iconCls = StringUtils.isNotEmpty(vo.getIconCls()) ? vo.getIconCls() : "fa fa-angle-double-right";
            sb.append("<i class='"+iconCls+"'></i> ");
            if (!vo.isLeaf()){
                sb.append("<span>"+vo.getName()+"</span>");
                if (childSize>0){
                    sb.append("<i class=\"fa fa-angle-left pull-right\"></i>");
                }
            }else{
                sb.append(vo.getName());
            }
            sb.append("</a>");
            if (childSize>0) {
                sb.append("<ul class='treeview-menu'>");
                generateMenu(sb, vo.getChildren());
                sb.append("</ul>");
            }
            sb.append("</li>");
        }
    }

    private List<FuncVo> denormalize(List<Func> funcs) {
        List<FuncVo> result = new ArrayList<>();
        Map<Long, FuncVo> funcMap = new HashMap<>();
        for (Func func : funcs) {
            FuncVo newVo = new FuncVo(func);
            funcMap.put(func.getId(), newVo);
            if (func.getLevel() == 0) {
                result.add(newVo);
            }
            Long parent = func.getParent();
            if (parent != null) {
                FuncVo vo = funcMap.get(parent);
                vo.getChildren().add(newVo);
            }
        }
        return result;
    }

    public static class FuncVo extends Func {

        public FuncVo(Func func) {
            setId(func.getId());
            setName(func.getName());
            setLevel(func.getLevel());
            setSeqNo(func.getSeqNo());
            setIconCls(func.getIconCls());
            setParent(func.getParent());
            setUrl(func.getUrl());
            setLeaf(func.isLeaf());
        }

        private List<FuncVo> children = new ArrayList<>();

        public List<FuncVo> getChildren() {
            return children;
        }

        public void setChildren(List<FuncVo> children) {
            this.children = children;
        }
    }
}
