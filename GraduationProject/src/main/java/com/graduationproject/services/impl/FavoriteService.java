package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CustomResponse;
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
import java.util.Optional;

/**
 * Service implementation for managing favorites.
 */
@Data
@Service
@RequiredArgsConstructor
public class FavoriteService {

    private final UserRepository userRepository;
    private final FavoriteRepository favoriteRepository;

    private final UserProfileService userProfileService;

    /**
     * Manages adding or removing a user from favorites.
     * @param userId The ID of the user
     * @param favoriteUserID The ID of the user to be added or removed from favorites
     * @return Response indicating the success of the operation
     */

    /* In the fav part I make that the user and the commuter have thier own favs,
    So If the user add commuter x this commuter x will be added to the user's fav list
    but in the commuter x list it will not be shown till he makes him fav back */
    @Transactional
    public CustomResponse manageFavoriteUser(Integer userId, Integer favoriteUserID) {
        Optional<User> userOptional = userRepository.findById(userId);
        Optional<User> commuterOptional = userRepository.findById(favoriteUserID);

        if (userOptional.isEmpty() || commuterOptional.isEmpty()) {
            return CustomResponse.builder()
                    .status(HttpStatus.NOT_FOUND.value())
                    .message("User or commuter not found")
                    .build();
        }

        User user = userOptional.get();
        User commuter = commuterOptional.get();

        if (user.getId() == commuter.getId()) {
            return CustomResponse.builder()
                    .status(HttpStatus.BAD_REQUEST.value())
                    .message("Cannot add yourself to favorites")
                    .build();
        }

        if (favoriteRepository.existsByUserIdAndFavoriteUserId(userId, favoriteUserID)) {
            favoriteRepository.deleteByUserIdAndFavoriteUserId(userId, favoriteUserID);
            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Removed successfully")
                    .build();
        } else {
            Favorite favorite = new Favorite();
            favorite.setUser(user);
            favorite.setFavoriteUser(commuter);
            favoriteRepository.save(favorite);
            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Added successfully")
                    .build();
        }
    }


    public CustomResponse getUserFavorites(Integer userId){
        Optional<User> optionalUser= userRepository.findById(userId);
        List<NormalProfileDTO> favoriteUserProfiles = new ArrayList<>();
        if (optionalUser.isPresent()){
            User existingUser = optionalUser.get();
            List<Favorite> favoriteList = favoriteRepository.findByUser(existingUser);
            for (Favorite favorite: favoriteList) {
               User favoriteUser = favorite.getFavoriteUser() ;
               NormalProfileDTO normalProfileDTO = new NormalProfileDTO();
               normalProfileDTO.setProfilePhotoURL(favoriteUser.getProfilePictureUrl());
               normalProfileDTO.setFullName(favoriteUser.getFullName());
               normalProfileDTO.setPhoneNumber(favoriteUser.getPhoneNumber());
               favoriteUserProfiles.add(normalProfileDTO);
            }
        }
        return CustomResponse.builder()
                .status(HttpStatus.OK.value())
                .data(favoriteUserProfiles)
                .build();
    }


}