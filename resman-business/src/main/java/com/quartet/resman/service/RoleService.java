package com.quartet.resman.service;

import com.google.common.collect.Lists;
import com.quartet.resman.entity.Permission;
import com.quartet.resman.entity.Func;
import com.quartet.resman.entity.Role;
import com.quartet.resman.repository.FuncDao;
import com.quartet.resman.repository.PermissionDao;
import com.quartet.resman.repository.RoleDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.*;


/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Service
public class RoleService {

    @Autowired
    private RoleDao roleDao;
    @Autowired
    private FuncDao funcDao;
    @Autowired
    private PermissionDao permDao;

    public Role getRole(Long uid) {
        return roleDao.findOne(uid);
    }

    public Set<Long> getRoleFuncIds(Long uid) {
        Role role = roleDao.findOne(uid);
        List<Func> funcs = role.getFuncs();
        Set<Long> result = new HashSet<>();
        for (Func func : funcs) {
            result.add(func.getId());
        }
        return result;
    }

    public Page<Role> getRoles(Pageable page) {
        return roleDao.findAll(page);
    }

    public Page<Role> getRoles(Specification<Role> spec, Pageable page) {
        return roleDao.findAll(spec, page);
    }

    public List<Role> getRoles(String role) {
        return roleDao.findByRole(role);
    }

    public List<Role> getRoles(){
        return roleDao.findAll();
    }

    public List<Permission> getRoleNotAssignedPerm(Long uid) {
        return permDao.findPermNotAssignedForRole(uid);
    }

    public List<Permission> getRolePerm(Long uid) {
        Role role = roleDao.findOne(uid);
        Set<Permission> pset = role.getPermissions();
        List<Permission> result = Lists.newArrayList(pset);
        return result;
    }

    public boolean roleExistExcludeSelf(Long uid, String role) {
        return roleDao.findByIdNotAndRole(uid, role).size() > 0 ? true : false;
    }

    public void addRole(Role role) {
        roleDao.save(role);
    }

    public void deleteRole(Long uid) {
        roleDao.delete(uid);
    }

    public void deleteRole(Role role) {
        roleDao.delete(role);
    }

    public void deleteRole(List<Long> ids) {
        if (ids != null) {
            for (Long id : ids) {
                roleDao.delete(id);
            }
        }
    }

    public void updateRoleFunc(Long rid, Set<Long> funcIds) {
        Role role = roleDao.findOne(rid);
        role.getFuncs().clear();
        for (Long fid : funcIds) {
            role.getFuncs().add(funcDao.getOne(fid));
        }
        roleDao.save(role);
    }

    public void updateRolePerm(Long rid, Set<Long> permIds) {
        Role role = roleDao.findOne(rid);
        role.getPermissions().clear();
        for (Long pid : permIds) {
            role.getPermissions().add(permDao.findOne(pid));
        }
        roleDao.save(role);
    }
}
