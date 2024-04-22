package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.UserRepository;
import com.graduationproject.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;

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
            // Check if the user exists before attempting to delete
            Optional<User> optionalUser = userRepository.findById(id);
            if (optionalUser.isEmpty()) {
                return CustomResponse.builder()
                                .status(HttpStatus.NOT_FOUND.value()) // HTTP 404
                                .message("User with ID " + id + " not found.")
                                .build();
            }

            userRepository.deleteById(id);

            return CustomResponse.builder()
                            .status(HttpStatus.OK.value()) // HTTP 200
                            .message("User deleted successfully.")
                            .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                            .status(HttpStatus.INTERNAL_SERVER_ERROR.value()) // HTTP 500
                            .message("An error occurred while deleting the user.")
                            .data(e.getMessage()) // Optionally include exception message
                            .build();
        }
    }

}