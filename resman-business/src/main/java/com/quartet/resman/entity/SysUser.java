package com.quartet.resman.entity;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.HashSet;
import java.util.Set;

/**
 * 系统用户
 * @author lcheng
 * @version 1.0
 */
@Entity
@Table(name = "s_sys_users")
public class SysUser {

    public static enum State{
        New,Normal,Online,Locked,Unused
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Length(max = 32,min = 5)
    @Column(name = "sysName", length = 32)
    private String sysName;

    @NotNull
    @Email
    @Length(max = 100)
    @Column(name = "email",length = 50)
    private String email;

    @NotNull
    @Length(max = 50,min = 6)
    @Column(name = "passwd", length = 50)
    private String passWd;

    @Column(name = "salt",length = 32)
    private String salt;

    @Enumerated
    private State state;

    @ManyToMany
    @JoinTable(name = "s_user_role",joinColumns = @JoinColumn(name = "sysUserId"),
            inverseJoinColumns = @JoinColumn(name = "roleId"))
    private Set<Role> roles = new HashSet<>();

    public SysUser() {}

    public SysUser(String sysName,String passWd){
        this.sysName = sysName;
        this.passWd = passWd;
        this.state = State.New;
    }

    public SysUser(String sysName, String passWd, String salt) {
        this.sysName = sysName;
        this.passWd = passWd;
        this.salt = salt;
        this.state = State.New;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSysName() {
        return sysName;
    }

    public void setSysName(String name) {
        this.sysName = name;
    }

    public String getPassWd() {
        return passWd;
    }

    public void setPassWd(String passWd) {
        this.passWd = passWd;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public State getState() {
        return state;
    }

    public void setState(State state) {
        this.state = state;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }
}
