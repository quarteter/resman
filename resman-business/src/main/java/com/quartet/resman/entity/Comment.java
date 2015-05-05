package com.quartet.resman.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

/**
 * User: xwang
 * Date: 15-2-26
 * 资源评论表，对精品课，课程，作业等资源的评论
 */
@Entity
@Table(name = "r_comment")
public class Comment {
    public static enum CommentType{
        Course("1"),Homework("2");
       // Course ,Homework /*根据需要增加吧*/
        private String value;
        CommentType(String _value)
        {
            this.value = _value;
        }
        public static CommentType from( String va )
        {

            if( "0".compareTo(va) == 0)
                return CommentType.Course;
            else if( "1".compareTo(va) == 0 )
                return CommentType.Homework;
            return null;
        }
        public String getValue() { return value; }


    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private  String resourceid;

    @Enumerated
    private CommentType type;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "userid")
    private User crtuser;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date crtdate;

    private String content;

    public void setId(Long id) {
        this.id = id;
    }



    public void setType(CommentType type) {
        this.type = type;
    }

    public void setCrtuser(User crtuser) {
        this.crtuser = crtuser;
    }

    public void setCrtdate(Date crtdate) {
        this.crtdate = crtdate;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getId() {

        return id;
    }

    public String getResourceid() {
        return resourceid;
    }

    public void setResourceid(String resourceid) {
        this.resourceid = resourceid;
    }

    public CommentType getType() {
        return type;
    }

    public User getCrtuser() {
        return crtuser;
    }

    public Date getCrtdate() {
        return crtdate;
    }

    public String getContent() {
        return content;
    }
}
