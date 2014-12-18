package com.quartet.resman.repository;

import com.quartet.resman.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public interface UserDao extends JpaRepository<User,Long>,JpaSpecificationExecutor<User> {

}
