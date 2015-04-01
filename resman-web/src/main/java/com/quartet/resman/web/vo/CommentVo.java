package com.quartet.resman.web.vo;

import java.util.Date;


public class CommentVo {

    private Long id;

    private  Long resourceid;

    private String type;

    private Long crtuser;

    private Date crtdate;

    private String content;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getResourceid() {
        return resourceid;
    }

    public void setResourceid(Long resourceid) {
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
}
