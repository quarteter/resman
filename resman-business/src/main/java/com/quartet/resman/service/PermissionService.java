package com.quartet.resman.service;

import com.quartet.resman.entity.Permission;
import com.quartet.resman.repository.PermissionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Service
public class PermissionService {

    @Autowired
    private PermissionDao permissionDao;

    public void addPermission(Permission permission) {
        permissionDao.save(permission);
    }

    public Page<Permission> getPermissions(Pageable page) {
        return permissionDao.findAll(page);
    }

    public Page<Permission> getPermissions(Specification spec, Pageable page) {
        return permissionDao.findAll(spec, page);
    }

    public Permission getPermission(Long uid){
        return permissionDao.findOne(uid);
    }

    public List<Permission> getPermissions(){
        return permissionDao.findAll();
    }

    public void deletePerms(List<Long> ids) {
        if (ids != null && ids.size() > 0) {
            for (Long id : ids) {
                permissionDao.delete(id);
            }
        }
    }
}
