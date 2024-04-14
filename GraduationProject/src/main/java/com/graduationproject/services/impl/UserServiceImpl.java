package com.graduationproject.services.impl;

import com.graduationproject.repositories.UserRepository;
import com.graduationproject.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * Implementation of the UserService interface providing operations related to user management.
 */
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;

    /**
     * Retrieves a UserDetailsService instance for loading user details by username.
     * @return A UserDetailsService instance
     */
    @Override
    public UserDetailsService userDetailsService(){
        return new UserDetailsService() {
            @Override
            public UserDetails loadUserByUsername(String username) {
                return userRepository.findByUsername(username)
                        .orElseThrow(() -> new UsernameNotFoundException("User Not Found "));
            }
        };
    }

    /**
     * Deletes a user by their ID.
     * @param id The ID of the user to delete
     * @return A ResponseEntity indicating the status of the operation
     */
    public ResponseEntity<String> deleteById(Integer id){
        userRepository.deleteById(id);
        return ResponseEntity.ok("User Deleted Successfully");
    }
}