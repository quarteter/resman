package com.quartet.resman.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by lcheng on 2015/3/24.
 * 新闻
 */
@Entity
@Table(name = "r_info")
public class Info {

    public enum Type {
        news,knowledge,skillContest,teacherGroup
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String crtuser;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date crtdate;

    private String title;
    private boolean publish;
    @Lob
    @Basic(fetch = FetchType.LAZY)
    private String content;

    private boolean bannerNews;
    //信息的图片路径
    private String imgPath;
    @Enumerated
    private Type type;

    public boolean isBannerNews() {
        return bannerNews;
    }

    public void setBannerNews(boolean bannerNews) {
        this.bannerNews = bannerNews;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCrtuser() {
        return crtuser;
    }

    public void setCrtuser(String crtuser) {
        this.crtuser = crtuser;
    }

    public Date getCrtdate() {
        return crtdate;
    }

    public void setCrtdate(Date crtdate) {
        this.crtdate = crtdate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public boolean isPublish() {
        return publish;
    }

    public void setPublish(boolean publish) {
        this.publish = publish;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }
}
