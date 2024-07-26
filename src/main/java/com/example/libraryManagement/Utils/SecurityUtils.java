package com.example.libraryManagement.Utils;

import com.example.libraryManagement.model.entity.Account;
import io.jsonwebtoken.Jwt;
import org.springframework.boot.autoconfigure.security.oauth2.resource.OAuth2ResourceServerProperties;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.List;
import java.util.Optional;

public class SecurityUtils {

    public static Optional<UserDetails> getCurrentLoggedInUser(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return Optional.ofNullable(extractPrincipal(authentication));
    }

    private static UserDetails extractPrincipal(Authentication authentication) {
        if (authentication == null) {
            return null;
        } else if (authentication.getPrincipal() instanceof UserDetails springSecurityUser) {
            return springSecurityUser;
        }
        return null;
    }
    public static String getCurrentLoggedInUserName() {
        Optional<UserDetails> userDetails= getCurrentLoggedInUser();;
        return userDetails.map(UserDetails::getUsername)
                .orElse(new RuntimeException("No current logged in account").getMessage());
    }


}
