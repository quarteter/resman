package com.quartet.resman.entity;

import com.quartet.resman.utils.Types;

import java.lang.reflect.Type;
import java.util.Date;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class Entry {
    protected String uuid;
    protected String name;
    protected String path;
    protected Date created;
    protected String createBy;

    private String status;
    private String visibility;

    public Entry(){}

    public Entry(String path,String createBy, String status, String visibility) {
        this.path = path;
        this.createBy = createBy;
        this.status = status;
        this.visibility = visibility;
    }

    public Entry(String path,String createBy){
        this(path,createBy, Types.Status.UnReviewed.getValue(), Types.Visibility.All.getValue());
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getVisibility() {
        return visibility;
    }

    public void setVisibility(String visibility) {
        this.visibility = visibility;
    }

    @Override
    public String toString() {
        return "Entry{" +
                "uuid='" + getName() + '\'' +
                "name='" + getName() + '\'' +
                ", path='" + path + '\'' +
                ", created=" + created +
                ", createBy='" + createBy + '\'' +
                ", status='" + status + '\'' +
                ", visibility='" + visibility + '\'' +
                '}';
    }
}
