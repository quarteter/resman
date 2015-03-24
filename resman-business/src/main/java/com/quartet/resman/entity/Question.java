package com.quartet.resman.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * User: qfxu
 * Date: 15-1-12
 */
@Entity
@Table(name = "r_ques")
public class Question {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "crtuser")
    private User crtuser;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date crtdate;

    private String title;

    private String content;

    private String state;

    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Answer> answers = new ArrayList<Answer>();

    public Question() {
        setState("0");
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    public void addAnswer( Answer answer )
    {
        answers.add(answer);
    }
}
