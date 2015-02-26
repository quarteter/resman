package com.quartet.resman.web.vo;

import java.util.List;

/**
 * @author: lcheng
 * @date: 2015/2/24
 * @version: 1.0
 */
public class FileFuncDef {

    private String name;
    private String title;
    private String rootDir;
    private boolean rootDirPersonal;
    private List<FileFuncMenu> menus;
    private List<FileFuncMenu> moreMenus;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getRootDir() {
        return rootDir;
    }

    public void setRootDir(String rootDir) {
        this.rootDir = rootDir;
    }

    public boolean isRootDirPersonal() {
        return rootDirPersonal;
    }

    public void setRootDirPersonal(boolean rootDirPersonal) {
        this.rootDirPersonal = rootDirPersonal;
    }

    public List<FileFuncMenu> getMenus() {
        return menus;
    }

    public void setMenus(List<FileFuncMenu> menus) {
        this.menus = menus;
    }

    public List<FileFuncMenu> getMoreMenus() {
        return moreMenus;
    }

    public void setMoreMenus(List<FileFuncMenu> moreMenus) {
        this.moreMenus = moreMenus;
    }
}
