package com.quartet.resman.entity;

import javax.persistence.*;

/**
 * Created by lcheng on 2015/5/1.
 */
@Entity
@Table(name = "r_doc_courses")
public class DocCourse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 40)
    private String docUid;

    @Column(length = 40)
    private String name;

    @Column(length = 30)
    private String teacher;

    private String brief;

    @Lob
    @Basic(fetch = FetchType.LAZY)
    private String description;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDocUid() {
        return docUid;
    }

    public void setDocUid(String docUid) {
        this.docUid = docUid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
