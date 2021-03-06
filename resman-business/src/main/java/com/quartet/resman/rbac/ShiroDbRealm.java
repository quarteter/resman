package com.quartet.resman.rbac;

import com.quartet.resman.entity.Role;
import com.quartet.resman.entity.SysUser;
import com.quartet.resman.entity.User;
import com.quartet.resman.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.Set;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class ShiroDbRealm extends AuthorizingRealm {

    private UserService userService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
        Long uid = shiroUser.getId();
        List<String> roles = userService.getUserRoleStrs(uid);
        List<String> perms = userService.getUserPermStrs(uid);
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.addRoles(roles);
        info.addStringPermissions(perms);
        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token)
            throws AuthenticationException {
        UsernamePasswordToken upToken = (UsernamePasswordToken) token;
        String sysName = upToken.getUsername();
        SysUser sysUser = userService.getSysUser(sysName);
        User user = userService.getUser(sysUser.getId());
        if (sysUser != null) {
            ShiroUser shiroUser = new ShiroUser(sysUser.getId(), sysUser.getSysName());
            shiroUser.setRealName(user.getName());
            Role role = getFirstRole( sysUser.getRoles() );
            if( role != null )
            {
                shiroUser.setRoleName( role.getName() );
                shiroUser.setRoleId( role.getId() );
            }
            SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(shiroUser, sysUser.getPassWd(),
                    ByteSource.Util.bytes(sysUser.getSalt()), getName());
            return info;
        }
        return null;
    }

    @PostConstruct
    public void initCredentialsMatcher() {
        CredentialsMatcher matcher = new InternalCredentialMatcher();
        setCredentialsMatcher(matcher);
    }

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }


    private Role getFirstRole( Set<Role> roles )
    {
        if( roles == null || roles.size() == 0 )
            return null;
        return roles.iterator().next();
    }
}
