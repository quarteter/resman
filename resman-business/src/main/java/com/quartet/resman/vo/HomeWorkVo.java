package com.quartet.resman.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by XWANG on 2015/2/27.
 */
@Entity
@Table(name = "v_homework")
public class HomeWorkVo {
    @Id
    private Long id;
    private Long hkId;

    private Long submitterId;
    private String submitter;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date submitDate;

    @Column(length = 120)
    private String fileName;

    private Float score;

    @Column(length = 120)
    private String path;

    @Column(length = 60)
    private String docUid;

    private String name;

    private String classNo;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getHkId() {
        return hkId;
    }

    public void setHkId(Long hkId) {
        this.hkId = hkId;
    }

    public Long getSubmitterId() {
        return submitterId;
    }

    public void setSubmitterId(Long submitterId) {
        this.submitterId = submitterId;
    }

    public String getSubmitter() {
        return submitter;
    }

    public void setSubmitter(String submitter) {
        this.submitter = submitter;
    }

    public Date getSubmitDate() {
        return submitDate;
    }

    public void setSubmitDate(Date submitDate) {
        this.submitDate = submitDate;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Float getScore() {
        return score;
    }

    public void setScore(Float score) {
        this.score = score;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
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

    public String getClassNo() {
        return classNo;
    }

    public void setClassNo(String classNo) {
        this.classNo = classNo;
    }
}
