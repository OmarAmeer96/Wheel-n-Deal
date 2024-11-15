package com.graduationproject.services.impl;

import com.graduationproject.DTOs.ChangePasswordDTO;
import com.graduationproject.DTOs.NormalProfileDTO;
import com.graduationproject.DTOs.UserProfileDTO;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.UserRepository;
import com.graduationproject.utils.Utils;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserProfileService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public ResponseEntity<Object> updateUserProfile(UserProfileDTO userProfileDTO) {
        try {
            if (userProfileDTO == null) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "User profile data cannot be null."),
                        HttpStatus.BAD_REQUEST
                );
            }

            if (userProfileDTO.getId() == null) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "User ID is required."),
                        HttpStatus.BAD_REQUEST
                );
            }

            Optional<User> user = userRepository.findById(userProfileDTO.getId());
            if (user.isEmpty()) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.NOT_FOUND.value(), "message", "User with ID " + userProfileDTO.getId() + " not found."),
                        HttpStatus.NOT_FOUND
                );
            }

            User existingUser = user.get();

            existingUser.setFullName(userProfileDTO.getFullName());
            existingUser.setGender(userProfileDTO.getGender());
            existingUser.setCity(userProfileDTO.getCity());
            existingUser.setPhoneNumber(userProfileDTO.getPhone());
            existingUser.setNationalId(userProfileDTO.getNationalId());

            MultipartFile photo = userProfileDTO.getProfilePicture();
            if (photo != null && !photo.isEmpty()) {
                try {
                    String photoUrl = Utils.storePhotoAndGetUrl(photo);
                    existingUser.setProfilePictureUrl(photoUrl);
                } catch (Exception e) {
                    return new ResponseEntity<>(
                            Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "Failed to upload profile picture.", "error", e.getMessage()),
                            HttpStatus.INTERNAL_SERVER_ERROR
                    );
                }
            }

            userRepository.save(existingUser);

            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.OK.value(), "message", "Profile updated successfully."),
                    HttpStatus.OK
            );

        } catch (Exception e) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "An error occurred while updating the profile.", "error", e.getMessage()),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    private String getUsername(Integer id){
        Optional<User> user= userRepository.findById(id);
        return user.get().getUsername();
    }

    public ResponseEntity<Object> getNormalUserProfile(Integer id) {
        try {
            if (id == null) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "User ID must be provided."),
                        HttpStatus.BAD_REQUEST
                );
            }

            Optional<User> optionalUser = userRepository.findById(id);
            if (optionalUser.isEmpty()) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.NOT_FOUND.value(), "message", "User with ID " + id + " not found."),
                        HttpStatus.NOT_FOUND
                );
            }

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null || !authentication.isAuthenticated()) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.UNAUTHORIZED.value(), "message", "Authentication required."),
                        HttpStatus.UNAUTHORIZED
                );
            }

            String authenticatedUsername = authentication.getName();
            String userName = optionalUser.get().getUsername();
            if (!userName.equals(authenticatedUsername)) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.FORBIDDEN.value(), "message", "You are not authorized to view this profile."),
                        HttpStatus.FORBIDDEN
                );
            }

            User user = optionalUser.get();
            NormalProfileDTO normalProfileDTO = new NormalProfileDTO();
            normalProfileDTO.setProfilePhotoURL(user.getProfilePictureUrl());
            normalProfileDTO.setFullName(user.getFullName());
            normalProfileDTO.setPhoneNumber(user.getPhoneNumber());

            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.OK.value(), "message", "Profile retrieved successfully.", "data", normalProfileDTO),
                    HttpStatus.OK
            );

        } catch (Exception e) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "An error occurred while retrieving the profile.", "error", e.getMessage()),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    public ResponseEntity<Object> changePassword(ChangePasswordDTO changePasswordDTO) {
        if (changePasswordDTO.getUserId() == null) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "User ID must be provided."),
                    HttpStatus.BAD_REQUEST
            );
        }

        Optional<User> optionalUser = userRepository.findById(changePasswordDTO.getUserId());
        if (optionalUser.isEmpty()) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.NOT_FOUND.value(), "message", "User not found"),
                    HttpStatus.NOT_FOUND
            );
        }

        User user = optionalUser.get();

        if (!passwordEncoder.matches(changePasswordDTO.getOldPassword(), user.getPassword())) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "Old password is incorrect"),
                    HttpStatus.BAD_REQUEST
            );
        }

        if (!changePasswordDTO.getNewPassword().equals(changePasswordDTO.getConfirmPassword())) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "New password and confirm password do not match"),
                    HttpStatus.BAD_REQUEST
            );
        }

        user.setPassword(passwordEncoder.encode(changePasswordDTO.getNewPassword()));
        userRepository.save(user);

        return new ResponseEntity<>(
                Map.of("status", HttpStatus.OK.value(), "message", "Password changed successfully"),
                HttpStatus.OK
        );
    }

}