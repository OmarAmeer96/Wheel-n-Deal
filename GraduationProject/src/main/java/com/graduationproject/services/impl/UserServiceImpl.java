package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.entities.Order;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.OrderRepository;
import com.graduationproject.repositories.UserRepository;
import com.graduationproject.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
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

    private final OrderRepository orderRepository;

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

    public CustomResponse deleteById(Integer id) {
        try {
            userRepository.deleteById(id);
            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("User deleted successfully")
                    .build();
        } catch (EmptyResultDataAccessException e) {
            return CustomResponse.builder()
                    .status(HttpStatus.NOT_FOUND.value())
                    .message("User not found with ID: " + id)
                    .build();
        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while deleting the user")
                    .build();
        }
    }


}