package com.quartet.resman.repository;

import com.quartet.resman.entity.Func;
import com.quartet.resman.entity.SysUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public interface SysUserDao extends JpaRepository<SysUser,Long> {

    public List<SysUser> findByName(String name);

    public List<SysUser> findByIdNotAndName(Long uid, String name);

    @Query(value = "select f from SysUser u join u.roles r join r.funcs f where u.id =?1 and r.id = ?2 " +
            "order by f.level,f.seqNo")
    public List<Func> findUserRoleFunc(Long uid, Long roleId);
}
