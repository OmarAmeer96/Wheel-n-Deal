package com.graduationproject.services.impl;

import com.graduationproject.DTOs.UserDTO;
import com.graduationproject.entities.Role;
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

import java.util.List;
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

    public ResponseEntity<String> deleteById(Integer id, String phoneNumber) {
        if (id == null || id <= 0) {
            return ResponseEntity.badRequest().body("Invalid ID provided.");
        }
        if (phoneNumber == null || phoneNumber.isEmpty()) {
            return ResponseEntity.badRequest().body("Phone number cannot be null or empty.");
        }

        try {
            Optional<User> userOptional = userRepository.findByIdAndPhoneNumber(id, phoneNumber);
            if (userOptional.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found with ID: " + id + " and phone number: " + phoneNumber);
            }
            userRepository.deleteById(id);
            return ResponseEntity.ok("User deleted successfully.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred while deleting the user.");
        }
    }

    public ResponseEntity<?> findUsersByRole(Role role) {
        if (role == null) {
            return ResponseEntity.badRequest().body("Role cannot be null.");
        }
        try {
            List<UserDTO> users = userRepository.findUsersByRole(role);
            if (users.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No users found with the specified role.");
            }
            return ResponseEntity.ok(users);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred while retrieving users.");
        }
    }

    public ResponseEntity<?> countUsersByRole(Role role) {
        if (role == null) {
            return ResponseEntity.badRequest().body("Role parameter cannot be null.");
        }
        try {
            long userCount = userRepository.countUsersByRole(role);
            if (userCount == 0) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No users found with the specified role.");
            }
            return ResponseEntity.ok(userCount);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred while counting users.");
        }
    }
}