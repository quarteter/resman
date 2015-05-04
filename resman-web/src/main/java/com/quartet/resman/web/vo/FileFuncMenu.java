package com.quartet.resman.web.vo;

import java.util.List;

/**
 * @author: lcheng
 * @date: 2015/2/24
 * @version: 1.0
 */
public class FileFuncMenu {
    private String id;
    private String name;
    private String action;
    private String iconCls;
    private String type;
    private List<FileFuncMenu> children;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getIconCls() {
        return iconCls;
    }

    public void setIconCls(String iconCls) {
        this.iconCls = iconCls;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<FileFuncMenu> getChildren() {
        return children;
    }

    public void setChildren(List<FileFuncMenu> children) {
        this.children = children;
    }
}
