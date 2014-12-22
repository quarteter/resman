package com.quartet.resman.repository;

import com.quartet.resman.entity.Func;
import com.quartet.resman.entity.SysUser;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public interface SysUserDao extends JpaRepository<SysUser,Long> {

    public List<SysUser> findBySysName(String name);

    public List<SysUser> findByIdNotAndSysName(Long uid, String name);

    @Query(value = "select f from SysUser u join u.roles r join r.funcs f where u.id =?1 and r.id = ?2 " +
            "order by f.level,f.seqNo")
    public List<Func> findUserRoleFunc(Long uid,Long roleId);

    @Query(value = "select f from SysUser u join u.roles r join r.funcs f where u.id =?1 " +
            "order by f.level,f.seqNo")
    public List<Func> findUserRoleFunc(Long uid);

    @Query(value = "select f from SysUser u join u.roles r join r.funcs f where u.id =?1 and f.url !=null and f.url !='' " +
            "order by f.level,f.seqNo")
    public List<Func> findUserFuncWithUrl(Long uid,Pageable page);
}