package com.graduationproject.services;

import com.graduationproject.entities.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserService {
        UserDetailsService userDetailsService();
}
