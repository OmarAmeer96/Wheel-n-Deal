package com.graduationproject.services.impl;

import com.graduationproject.DTOs.*;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.UserRepository;
import com.graduationproject.utils.Utils;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;

/**
 * Service class for managing user profiles.
 */
@Service
@RequiredArgsConstructor
public class UserProfileService {

    private final UserRepository userRepository;

    private final PasswordEncoder passwordEncoder;


    public CustomResponse updateUserProfile(UserProfileDTO userProfileDTO) {
        try {
            Optional<User> user = userRepository.findById(userProfileDTO.getId());
            if (user.isEmpty()) {
                return CustomResponse.builder()
                        .status(HttpStatus.NOT_FOUND.value())
                        .message("User with ID " + userProfileDTO.getId() + " not found.")
                        .build();
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
                    return CustomResponse.builder()
                            .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .message("Failed to upload profile picture.")
                            .data(e.getMessage())
                            .build();
                }
            }


            userRepository.save(existingUser);

            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Profile updated successfully.")
                    .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while updating the profile.")
                    .data(e.getMessage())
                    .build();
        }
    }


    private String getUsername(Integer id){
        Optional<User> user= userRepository.findById(id);
        return user.get().getUsername();
    }

    public CustomResponse getNormalUserProfile(Integer id) {
        try {
            if (id == null) {
                return CustomResponse.builder()
                        .status(HttpStatus.BAD_REQUEST.value())
                        .message("User ID must be provided.")
                        .build();
            }

            Optional<User> optionalUser = userRepository.findById(id);
            if (optionalUser.isEmpty()) {
                return CustomResponse.builder()
                        .status(HttpStatus.NOT_FOUND.value())
                        .message("User with ID " + id + " not found.")
                        .build();
            }

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null || !authentication.isAuthenticated()) {
                return CustomResponse.builder()
                        .status(HttpStatus.UNAUTHORIZED.value())
                        .message("Authentication required.")
                        .build();
            }

            String authenticatedUsername = authentication.getName();
            String userName = optionalUser.get().getUsername();

            if (!userName.equals(authenticatedUsername)) {
                return CustomResponse.builder()
                        .status(HttpStatus.FORBIDDEN.value())
                        .message("You are not authorized to view this profile.")
                        .build();
            }

            User user = optionalUser.get();
            ProfileDTO profileDTO = new ProfileDTO();
            profileDTO.setProfilePhotoURL(user.getProfilePictureUrl());
            profileDTO.setFullName(user.getFullName());
            profileDTO.setPhoneNumber(user.getPhoneNumber());
            profileDTO.setRole(user.getRole());
            profileDTO.setCity(user.getCity());
            profileDTO.setGender(user.getGender());
            profileDTO.setNationalId(user.getNationalId());

            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Profile retrieved successfully.")
                    .data(profileDTO)
                    .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while retrieving the profile.")
                    .data(e.getMessage())
                    .build();
        }
    }

    public CustomResponse changePassword(ChangePasswordDTO changePasswordDTO) {
        User user = userRepository.findById(changePasswordDTO.getUserId()).orElse(null);

        if (user == null) {
            return CustomResponse.builder()
                    .status(404)
                    .message("User not found")
                    .build();
        }

        if (!passwordEncoder.matches(changePasswordDTO.getOldPassword(), user.getPassword())) {
            return CustomResponse.builder()
                    .status(400)
                    .message("Old password is incorrect")
                    .build();
        }

        if (!changePasswordDTO.getNewPassword().equals(changePasswordDTO.getConfirmPassword())) {
            return CustomResponse.builder()
                    .status(400)
                    .message("New password and confirm password do not match")
                    .build();
        }


        user.setPassword(passwordEncoder.encode(changePasswordDTO.getNewPassword()));
        userRepository.save(user);

        return CustomResponse.builder()
                .status(200)
                .message("Password changed successfully")
                .build();
    }


}