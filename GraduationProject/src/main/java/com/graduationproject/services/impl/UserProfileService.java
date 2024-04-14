package com.graduationproject.services.impl;

import com.graduationproject.DTOs.NormalProfileDTO;
import com.graduationproject.DTOs.UserProfileDTO;
import com.graduationproject.entities.Role;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.UserRepository;
import com.graduationproject.utils.Utils;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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

    /**
     * Updates the user profile based on the provided UserProfileDTO.
     * @param userProfileDTO The DTO containing updated user profile details
     * @return A ResponseEntity indicating the status of the operation
     */
    public ResponseEntity<String> updateUserProfile(UserProfileDTO userProfileDTO) {
        Optional<User> user = userRepository.findById(userProfileDTO.getId());
        if (user.isPresent()) {
            User existingUser = user.get();
            existingUser.setFullName(userProfileDTO.getFullName());
            existingUser.setGender(userProfileDTO.getGender());
            existingUser.setCity(userProfileDTO.getCity());
            MultipartFile photo = userProfileDTO.getProfilePicture();
            if (photo != null && !photo.isEmpty()) {
                String photoUrl = Utils.storePhotoAndGetUrl(photo);
                existingUser.setProfilePictureUrl(photoUrl);
            }
            existingUser.setPhoneNumber(userProfileDTO.getPhone());

            if (existingUser.getRole() == Role.COMMUTER) {
                existingUser.setNationalId(userProfileDTO.getNationalId());
            }

            userRepository.save(existingUser);
            return ResponseEntity.ok("Profile updated successfully");
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update profile");
    }

    /**
     * Retrieves the username associated with the given user ID.
     * @param id The ID of the user
     * @return The username associated with the user ID
     */
    private String getUsername(Integer id){
        Optional<User> user= userRepository.findById(id);
        return user.get().getUsername();
    }

    /**
     * Retrieves the normal profile information for a user.
     * @param id The ID of the user whose profile to retrieve
     * @return A ResponseEntity containing the normal profile information
     */
    public ResponseEntity<NormalProfileDTO> getNormalUserProfile(Integer id) {
        String userName = getUsername(id);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()) {
            String authenticationUserName = authentication.getName();
            if (userName.equals(authenticationUserName)) {

                Optional<User> optionalUser = userRepository.findById(id);
                if (optionalUser.isPresent()) {
                    User user = optionalUser.get();

                    NormalProfileDTO normalProfileDTO = new NormalProfileDTO();
                    normalProfileDTO.setProfilePhotoURL(user.getProfilePictureUrl());
                    normalProfileDTO.setFullName(user.getFullName());
                    normalProfileDTO.setPhoneNumber(user.getPhoneNumber());

                    return ResponseEntity.ok(normalProfileDTO);
                }
            }
        }
        return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
    }
}