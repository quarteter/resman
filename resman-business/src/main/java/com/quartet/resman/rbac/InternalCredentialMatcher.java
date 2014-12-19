package com.quartet.resman.rbac;

import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SaltedAuthenticationInfo;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.codec.CodecSupport;
import org.apache.shiro.crypto.hash.Sha1Hash;
import org.apache.shiro.util.ByteSource;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class InternalCredentialMatcher extends CodecSupport implements CredentialsMatcher{
    @Override
    public boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) {
        Object tokenCredential = token.getCredentials();
        Object accountCredential = info.getCredentials();

        if(info instanceof SaltedAuthenticationInfo){
            ByteSource salt = ((SaltedAuthenticationInfo) info).getCredentialsSalt();
            Sha1Hash sha1Hash = new Sha1Hash(tokenCredential,salt);
            return sha1Hash.toHex().equals(accountCredential);
        }
        return false;
    }
}
