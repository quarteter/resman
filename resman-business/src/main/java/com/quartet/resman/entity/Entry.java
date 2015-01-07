package com.quartet.resman.entity;

import java.util.Date;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class Entry {

    protected String name;
    protected String path;
    protected Date created;
    protected String createBy;

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getName() {
        if (name!=null){
            return name;
        }else if (path!=null){
            int idx = path.lastIndexOf("/");
            if (idx>=0){
                return path.substring(idx+1);
            }else{
                return path;
            }
        }
        return null;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    @Override
    public String toString() {
        return "BaseFolder{" +
                "created=" + created +
                ", name='" + getName() + '\'' +
                ", path='" + path + '\'' +
                ", createBy='" + createBy + '\'' +
                '}';
    }
}
