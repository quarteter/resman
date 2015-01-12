package com.quartet.resman.entity;

import com.quartet.resman.utils.Types;

import java.util.Collection;
import java.util.List;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class Folder extends Entry {


    private String type;
    private List<Entry> entries;

    public Folder() {
    }

    public Folder(String path,String createBy,
                  String status, String visibility,String type) {
        super(path,createBy,status,visibility);
        this.type = type;
    }

    public Folder(String path,String createBy,String type){
        this(path,createBy, Types.Status.UnReviewed.getValue(),Types.Visibility.All.getValue(),type);
    }

    public List<Entry> getEntries() {
        return entries;
    }

    public void setEntries(List<Entry> entries) {
        this.entries = entries;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Folder{" +
                "type='" + type + '\'' +
                "} " + super.toString();
    }
}
