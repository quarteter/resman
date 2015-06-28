package com.quartet.resman.rbac;

import java.io.Serializable;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class ShiroUser implements Serializable{

    private Long id;
    private Long roleId;
    private String userName;
    private String roleName;
    private String realName;
    public ShiroUser(Long id,String userName) {
        this.userName = userName;
        this.id = id;
    }

    public ShiroUser(Long id,String userName,Long roleId) {
        this.id = id;
        this.userName = userName;
        this.roleId = roleId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }
}

