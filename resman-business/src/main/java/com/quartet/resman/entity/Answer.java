package com.quartet.resman.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

/**
 * User: qfxu
 * Date: 15-1-8
 */
@Entity
@Table(name = "r_anwser")
public class Answer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "crtuser")
    private User crtuser;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date crtdate;

    private String content;

    public Long getQuesId() {
        return quesId;
    }

    public void setQuesId(Long quesId) {
        this.quesId = quesId;
    }

    private Long quesId;

    /*
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="quesId")
    private Question question;
    */
    public Answer() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }




    public void setCrtuser(User crtuser) {
        this.crtuser = crtuser;
    }

    public User getCrtuser() {
        return crtuser;
    }

    /*
    public void setQuestion(Question question) {
        this.question = question;
    }

    public Question getQuestion() {
        return question;
    }
    */

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
