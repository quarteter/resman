package com.quartet.resman.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by lcheng on 2015/3/24.
 * 资源评论
 */
@Entity
@Table(name = "r_res_comments")
public class ResComment extends BaseText {

    private String resId;

    public String getResId() {
        return resId;
    }

    public void setResId(String resId) {
        this.resId = resId;
    }
}
