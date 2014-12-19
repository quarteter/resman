package com.quartet.resman.service;

import static com.google.common.base.Preconditions.*;

import com.google.common.collect.Lists;
import com.quartet.resman.entity.*;
import org.apache.commons.lang3.StringUtils;
import com.quartet.resman.core.utils.Digests;
import com.quartet.resman.core.utils.Encodes;
import com.quartet.resman.repository.RoleDao;
import com.quartet.resman.repository.SysUserDao;
import com.quartet.resman.repository.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Service
public class UserService {
    private static final int SALT_SIZE = 8;

    @Autowired
    private UserDao userDao;
    @Autowired
    private SysUserDao sysUserDao;
    @Autowired
    private RoleDao roleDao;

    public void addUser(User user) {
        userDao.save(user);
    }

    public void addSysUser(SysUser sysUser, User user) {
        checkNotNull(sysUser);
        encryptPassword(sysUser);
        sysUserDao.save(sysUser);
        Long sysUid = sysUser.getId();
        if (sysUid != null) {
            user.setId(sysUid);
            userDao.save(user);
        }
    }

    public Page<User> getUser(Pageable page) {
        return userDao.findAll(page);
    }

    public Page<User> getUser(Specification<User> spec, Pageable page) {
        return userDao.findAll(spec, page);
    }

    public User getUser(Long uid) {
        return userDao.findOne(uid);
    }

    public SysUser getSysUser(Long sysUid) {
        return sysUserDao.findOne(sysUid);
    }

    public SysUser getSysUser(String sysName) {
        List<SysUser> users = sysUserDao.findBySysName(sysName);
        return users.size() > 0 ? users.get(0) : null;
    }

    public List<Long> getUserRole(Long sysUid) {
        SysUser user = sysUserDao.findOne(sysUid);
        Set<Role> roles = user.getRoles();
        List<Long> result = new ArrayList<>(roles.size());
        for (Role role : roles) {
            result.add(role.getId());
        }
        return result;
    }

    public List<String> getUserRoleStrs(Long sysUid) {
        SysUser user = sysUserDao.findOne(sysUid);
        Set<Role> roles = user.getRoles();
        List<String> result = new ArrayList<>(roles.size());
        for (Role role : roles) {
            result.add(role.getRole());
        }
        return result;
    }

    public List<String> getUserPermStrs(Long sysUid) {
        SysUser user = sysUserDao.findOne(sysUid);
        Set<Role> roles = user.getRoles();
        List<String> result = new ArrayList<>();
        for (Role role : roles) {
            Set<Permission> perms = role.getPermissions();
            for (Permission perm : perms) {
                result.add(perm.getPermission());
            }
        }
        return result;
    }

    //public List<String> getUserRole

//    public List<Func> getSysUserFunc(Long userId, Long roleId) {
//        if (roleId == null) {
//            SysUser u = sysUserDao.getOne(userId);
//            Set<Role> role = u.getRoles();
//            if (role.size() > 0) {
//                roleId = role.iterator().next().getId();
//            } else {
//                return null;
//            }
//        }
//        return sysUserDao.findUserRoleFunc(userId, roleId);
//    }

    /**
     * 获得系统用户的功能列表
     *
     * @param userId
     * @return
     */
    public List<Func> getSysUserFunc(Long userId) {
        return sysUserDao.findUserRoleFunc(userId);
    }

    public void updateUserRole(Long sysUid, Long[] roleIds) {
        SysUser user = sysUserDao.findOne(sysUid);
        user.getRoles().clear();
        for (Long rid : roleIds) {
            user.getRoles().add(roleDao.findOne(rid));
        }
        sysUserDao.save(user);
    }

    public void deleteUser(Long userId) {
        //User user = userDao.findOne(userId);
        //Long sysUserId = user.getSysUserId();
        userDao.delete(userId);
        sysUserDao.delete(userId);
//        if (sysUserId != null) {
//            sysUserDao.delete(sysUserId);
//        }
    }

    public void deleteUser(List<Long> users) {
        if (users != null) {
            for (Long uid : users) {
                deleteUser(uid);
            }
        }
    }

    public boolean sysUserNameExist(String name) {
        List<SysUser> users = sysUserDao.findBySysName(name);
        return users != null && users.size() > 0 ? true : false;
    }

    public boolean sysUserNameExist(Long sysUid, String name) {
        List<SysUser> users = sysUserDao.findByIdNotAndSysName(sysUid, name);
        return users != null && users.size() > 0 ? true : false;
    }

    private void encryptPassword(SysUser user) {
        if (StringUtils.isEmpty(user.getSalt())) {
            String hexSalt = Digests.generateHexSalt(SALT_SIZE);
            user.setSalt(hexSalt);
        }
        byte[] pwdBytes = Digests.sha1(user.getPassWd().getBytes(), user.getSalt().getBytes());
        user.setPassWd(Encodes.encodeHex(pwdBytes));
    }

}
