package com.graduationproject.services;

import org.springframework.security.core.userdetails.UserDetailsService;

/**
 * Interface defining operations related to user services.
 */
public interface UserService {

        /**
         * Retrieves a UserDetailsService.
         * This method is responsible for providing a UserDetailsService, which is used for loading user-specific data during authentication.
         * @return A UserDetailsService implementation
         */
        UserDetailsService userDetailsService();
}
