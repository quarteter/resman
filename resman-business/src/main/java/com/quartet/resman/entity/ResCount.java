package com.quartet.resman.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by lcheng on 2015/3/24.
 * 资源评论
 */
@Entity
@Table(name = "r_res_count")
public class ResCount {

    @Id
    private String id;

    @Column(name = "view_count")
    private int viewCount;

    @Column(name = "down_count")
    private int downCount;

    public ResCount() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public int getDownCount() {
        return downCount;
    }

    public void setDownCount(int downCount) {
        this.downCount = downCount;
    }
}
