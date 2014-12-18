package com.quartet.resman.service;

import static com.google.common.base.Preconditions.*;

import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import com.quartet.resman.core.utils.Digests;
import com.quartet.resman.core.utils.Encodes;
import com.quartet.resman.entity.Func;
import com.quartet.resman.entity.Role;
import com.quartet.resman.entity.SysUser;
import com.quartet.resman.entity.User;
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

    public void addSysUser(SysUser sysUser, Long userId) {
        User user = userDao.findOne(userId);
        addSysUser(sysUser, user);
    }

    public void addSysUser(SysUser sysUser, User user) {
        checkNotNull(sysUser);
        encryptPassword(sysUser);
        sysUserDao.save(sysUser);
        Long sysUid = sysUser.getId();
        if (sysUid != null) {
            user.setSysUserId(sysUid);
            userDao.save(user);
        }
    }

    public void removeRoleForSysUser(Long sysUserId, Long roleId) {
        SysUser user = sysUserDao.findOne(sysUserId);
        Role role = roleDao.findOne(roleId);
        user.getRoles().remove(role);
        sysUserDao.save(user);
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

    public List<Long> getUserRoleByUser(Long uid) {
        User user = userDao.getOne(uid);
        Long sysUid = user.getSysUserId();
        if (sysUid != null) {
            return getUserRoleBySysUser(sysUid);
        } else {
            return Lists.newArrayList();
        }
    }

    public List<Long> getUserRoleBySysUser(Long sysUid) {
        SysUser user = sysUserDao.findOne(sysUid);
        Set<Role> roles = user.getRoles();
        List<Long> result = new ArrayList<>(roles.size());
        for (Role role : roles) {
            result.add(role.getId());
        }
        return result;
    }

    public List<Func> getSysUserFunc(Long userId, Long roleId) {
        if (roleId == null) {
            SysUser u = sysUserDao.getOne(userId);
            Set<Role> role = u.getRoles();
            if (role.size()>0){
                roleId = role.iterator().next().getId();
            } else {
                return null;
            }
        }
        return sysUserDao.findUserRoleFunc(userId,roleId);
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
        User user = userDao.findOne(userId);
        Long sysUserId = user.getSysUserId();
        userDao.delete(user);
        if (sysUserId != null) {
            sysUserDao.delete(sysUserId);
        }
    }

    public void deleteUser(List<Long> users) {
        if (users != null) {
            for (Long uid : users) {
                deleteUser(uid);
            }
        }
    }

    public boolean sysUserNameExist(String name) {
        List<SysUser> users = sysUserDao.findByName(name);
        return users != null && users.size() > 0 ? true : false;
    }

    public boolean sysUserNameExist(Long sysUid, String name) {
        List<SysUser> users = sysUserDao.findByIdNotAndName(sysUid, name);
        return users != null && users.size() > 0 ? true : false;
    }

    private void encryptPassword(SysUser user) {
        if (StringUtils.isEmpty(user.getSalt())) {
            String hexSalt = Digests.generateHexSalt(SALT_SIZE);
            user.setSalt(hexSalt);

            byte[] pwdBytes = Digests.sha1(user.getPassWd().getBytes(), hexSalt.getBytes());
            user.setPassWd(Encodes.encodeHex(pwdBytes));
        }
    }

}
