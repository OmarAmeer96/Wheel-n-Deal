package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.NormalProfileDTO;
import com.graduationproject.DTOs.UserProfileDTO;
import com.graduationproject.entities.Role;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.UserRepository;
import com.graduationproject.utils.Utils;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.NoSuchElementException;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserProfileService {

    private final UserRepository userRepository;

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

            if (existingUser.getRole() == Role.COMMUTER) {
                existingUser.setNationalId(userProfileDTO.getNationalId());
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

    private String getUsername(Integer id) {
        if (id == null) {
            throw new IllegalArgumentException("User ID must be provided.");
        }

        Optional<User> optionalUser = userRepository.findById(id);

        if (optionalUser.isEmpty()) {
            throw new NoSuchElementException("User with ID " + id + " not found.");
        }

        return optionalUser.get().getUsername();
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
            NormalProfileDTO normalProfileDTO = new NormalProfileDTO();
            normalProfileDTO.setProfilePhotoURL(user.getProfilePictureUrl());
            normalProfileDTO.setFullName(user.getFullName());
            normalProfileDTO.setPhoneNumber(user.getPhoneNumber());

            return CustomResponse.builder()
                            .status(HttpStatus.OK.value())
                            .message("Profile retrieved successfully.")
                            .data(normalProfileDTO)
                            .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                            .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .message("An error occurred while retrieving the profile.")
                            .data(e.getMessage())
                            .build();
        }
    }
}