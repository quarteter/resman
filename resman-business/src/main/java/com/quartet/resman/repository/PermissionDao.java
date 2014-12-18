package com.quartet.resman.repository;

import com.quartet.resman.entity.Permission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public interface PermissionDao extends JpaRepository<Permission, Long>,
        JpaSpecificationExecutor<Permission>{

        @Query(value = "select p from Permission p where not exists " +
                "(select r.permissions from Role r where r.id = ?1)")
        public List<Permission> findPermNotAssignedForRole(Long roleId);
}
