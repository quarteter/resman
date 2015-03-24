package com.quartet.resman.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by XWANG on 2015/1/14.
 */
@Entity
@Table(name = "v_question")
public class QuestionVo {
    public void setId(Long id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setCrtuser(String crtuser) {
        this.crtuser = crtuser;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setCrtdate(Date crtdate) {
        this.crtdate = crtdate;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setRescount(Long rescount) {
        this.rescount = rescount;
    }

    public Long getId() {

        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getCrtuser() {
        return crtuser;
    }

    public String getTitle() {
        return title;
    }

    public Date getCrtdate() {
        return crtdate;
    }

    public String getContent() {
        return content;
    }

    public Long getRescount() {
        return rescount;
    }

    @Id
    Long id;

    /**
     * 用户中文名
     */
    String username;

    /**
     * 用户登录名
     */
    String crtuser;


    String title;


    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date crtdate;

    public void setState(String state) {
        this.state = state;
    }

    public String getState() {

        return state;
    }

    /**
     * 内容
     */

    String content;

    Long rescount;

    String state;
}

