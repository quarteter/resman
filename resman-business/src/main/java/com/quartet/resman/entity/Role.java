package com.quartet.resman.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Entity
@Table(name = "s_roles")
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name",length = 60)
    private String name;

    @Column(name = "role",length = 60,nullable = false)
    private String role;
    @Column(name = "notes",length = 100)
    private String notes;

    @ManyToMany
    @JoinTable(name = "s_role_permission",joinColumns = @JoinColumn(name = "roleId"),
    inverseJoinColumns = @JoinColumn(name = "permId"))
    @JsonIgnore
    private Set<Permission> permissions = new HashSet<>();

    @ManyToMany
    @JoinTable(name = "s_role_func",joinColumns = @JoinColumn(name = "roleId"),
            inverseJoinColumns = @JoinColumn(name = "funcId"))
    @OrderBy("level asc,seqNo asc")
    @JsonIgnore
    private List<Func> funcs = new ArrayList<>();

    public Role(){}

    public Role(String name,String role, String notes) {
        this.name = name;
        this.role = role;
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

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Set<Permission> getPermissions() {
        return permissions;
    }

    public void setPermissions(Set<Permission> permissions) {
        this.permissions = permissions;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public List<Func> getFuncs() {
        return funcs;
    }

    public void setFuncs(List<Func> funcs) {
        this.funcs = funcs;
    }
}
