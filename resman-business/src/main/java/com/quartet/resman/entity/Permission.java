package com.quartet.resman.entity;

import javax.persistence.*;

/**
 * 权限信息
 *
 * @author lcheng
 * @version 1.0
 */
@Entity
@Table(name = "s_permissions")
public class Permission {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", length = 60)
    private String name;
    @Column(name = "resource", length = 60)
    private String resource;

    @Column(name = "perm", length = 60, nullable = false)
    private String permission;

    @Column(name = "notes", length = 100)
    private String notes;

    public Permission() {
    }

    public Permission(String name, String resource,String permission,String notes) {
        this.name = name;
        this.resource = resource;
        this.permission = permission;
        this.notes = notes;
    }

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

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission;
    }

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
