package com.graduationproject.services.impl;

import com.graduationproject.DTOs.NormalProfileDTO;
import com.graduationproject.entities.Favorite;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.FavoriteRepository;
import com.graduationproject.repositories.UserRepository;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Data
@Service
@RequiredArgsConstructor
public class FavoriteService {

    private final UserRepository userRepository;
    private final FavoriteRepository favoriteRepository;
    private final UserProfileService userProfileService;

    /* In the fav part I make that the user and the commuter have thier own favs,
    So If the user add commuter x this commuter x will be added to the user's fav list
    but in the commuter x list it will not be shown till he makes him fav back */
    @Transactional
    public ResponseEntity<?> manageFavoriteUser(Integer userId, Integer favoriteUserID) {
        if (userId == null || favoriteUserID == null || userId <= 0 || favoriteUserID <= 0) {
            return ResponseEntity.badRequest().body(Map.of("message", "Invalid user ID or favorite user ID"));
        }

        Optional<User> userOptional = userRepository.findById(userId);
        Optional<User> commuterOptional = userRepository.findById(favoriteUserID);

        if (userOptional.isEmpty() || commuterOptional.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "User or commuter not found"));
        }

        User user = userOptional.get();
        User commuter = commuterOptional.get();

        if (user.getId().equals(commuter.getId())) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Cannot add yourself to favorites"));
        }

        if (favoriteRepository.existsByUserIdAndFavoriteUserId(userId, favoriteUserID)) {
            favoriteRepository.deleteByUserIdAndFavoriteUserId(userId, favoriteUserID);
            return ResponseEntity.ok()
                    .body(Map.of("message", "Removed successfully"));
        } else {
            Favorite favorite = new Favorite();
            favorite.setUser(user);
            favorite.setFavoriteUser(commuter);
            favoriteRepository.save(favorite);
            return ResponseEntity.ok()
                    .body(Map.of("message", "Added successfully"));
        }
    }

    public ResponseEntity<?> getUserFavorites(Integer userId) {
        if (userId == null || userId <= 0) {
            return ResponseEntity.badRequest().body(Map.of("message", "Invalid user ID provided"));
        }

        Optional<User> optionalUser = userRepository.findById(userId);

        if (optionalUser.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "User not found"));
        }

        User existingUser = optionalUser.get();
        List<NormalProfileDTO> favoriteUserProfiles = new ArrayList<>();

        List<Favorite> favoriteList = favoriteRepository.findByUser(existingUser);

        for (Favorite favorite : favoriteList) {
            User favoriteUser = favorite.getFavoriteUser();
            NormalProfileDTO normalProfileDTO = new NormalProfileDTO();
            normalProfileDTO.setProfilePhotoURL(favoriteUser.getProfilePictureUrl());
            normalProfileDTO.setFullName(favoriteUser.getFullName());
            normalProfileDTO.setPhoneNumber(favoriteUser.getPhoneNumber());
            favoriteUserProfiles.add(normalProfileDTO);
        }
        return ResponseEntity.ok().body(favoriteUserProfiles);
    }

}