package com.quartet.resman.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Email;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

/**
 * 人员信息
 *
 * @author lcheng
 * @version 1.0
 */
@Entity
@Table(name = "s_users")
public class User {

    public static enum Sex {
        Female,Male
    }

    public static enum Type{
        Student,Teacher,Administrator
    }

    @Id
    private Long id;

    @Column(name = "name", length = 60, nullable = false)
    private String name;
    @Enumerated(EnumType.ORDINAL)
    private Sex sex;

    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd",locale ="zh",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date bod;

    @Enumerated(EnumType.ORDINAL)
    private Type userType;

    @Column(length = 50)
    private String className; //班级
    @Column(length = 20)
    private String studentNo; //学号
    @Column(length = 50)
    private String major;  //专业

    //Teacher的属性
    private String empNo; //工号
    private String title; //职称

    @Column(name = "phone_num", length = 13)
    private String phoneNum;
    @Column(name = "tel_num", length = 13)
    private String telNum;

//    private Long sysUserId;//系统用户标识

    @Lob()
    @Basic(fetch = FetchType.LAZY)
    private byte[] img;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Sex getSex() {
        return sex;
    }

    public void setSex(Sex sex) {
        this.sex = sex;
    }

    public Date getBod() {
        return bod;
    }

    public void setBod(Date bod) {
        this.bod = bod;
    }


//    public Long getSysUserId() {
//        return sysUserId;
//    }
//
//    public void setSysUserId(Long sysUserId) {
//        this.sysUserId = sysUserId;
//    }

    public byte[] getImg() {
        return img;
    }

    public void setImg(byte[] img) {
        this.img = img;
    }

    public Type getUserType() {
        return userType;
    }

    public void setUserType(Type userType) {
        this.userType = userType;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getStudentNo() {
        return studentNo;
    }

    public void setStudentNo(String studentNo) {
        this.studentNo = studentNo;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getTelNum() {
        return telNum;
    }

    public void setTelNum(String telNum) {
        this.telNum = telNum;
    }
}
