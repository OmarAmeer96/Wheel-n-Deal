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

@Service
@RequiredArgsConstructor
public class UserProfileService {

    private final UserRepository userRepository;

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
            existingUser.setPhone(userProfileDTO.getPhone());

            if (existingUser.getRole() == Role.COMMUTER) {
                existingUser.setNationalId(userProfileDTO.getNationalId());
            }

            userRepository.save(existingUser);
            return ResponseEntity.ok("Profile updated successfully");
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update profile");
    }

    private String getUsername(Integer id){
        Optional<User> user= userRepository.findById(id);
        return user.get().getUsername();
    }
    /* This method to get the profile by clicking of profile section
    * here we use the authentication to ensure that the id that we send
    * is the same id of the user because if the user send a request with his token but the different
    * id it will acceppt it and return another user profile , we compare the username of the user's id
    * and the one in the auth token and don't use IDs because the authentication obj contain the username as the unique value
    * */
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
                    normalProfileDTO.setPhoneNumber(user.getPhone());

                    return ResponseEntity.ok(normalProfileDTO);
                }
            }
        }
        return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
    }
}