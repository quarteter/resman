package com.quartet.resman.repository;

import com.quartet.resman.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public interface RoleDao extends JpaRepository<Role, Long>, JpaSpecificationExecutor<Role> {

    public List<Role> findByRole(String role);

    public List<Role> findByIdNotAndRole(Long uid, String role);
}
