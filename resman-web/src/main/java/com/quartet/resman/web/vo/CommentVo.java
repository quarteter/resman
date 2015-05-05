package com.quartet.resman.web.vo;

import java.util.Date;


public class CommentVo {

    private Long id;

    private  String resourceid;

    private String type;

    private Long crtuser;

    private String crtuserName;

    private Date crtdate;

    private String content;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getResourceid() {
        return resourceid;
    }

    public void setResourceid(String resourceid) {
        this.resourceid = resourceid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Long getCrtuser() {
        return crtuser;
    }

    public void setCrtuser(Long crtuser) {
        this.crtuser = crtuser;
    }

    public Date getCrtdate() {
        return crtdate;
    }

    public void setCrtdate(Date crtdate) {
        this.crtdate = crtdate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCrtuserName() {
        return crtuserName;
    }

    public void setCrtuserName(String crtuserName) {
        this.crtuserName = crtuserName;
    }
}
