package com.graduationproject.services;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Repository;

@Repository
public interface UserService {
        UserDetailsService userDetailsService();
}
