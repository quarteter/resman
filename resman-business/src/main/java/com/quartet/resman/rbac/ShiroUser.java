package com.quartet.resman.rbac;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class ShiroUser {

    private Long id;
    private Long roleId;
    private String userName;

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
}

