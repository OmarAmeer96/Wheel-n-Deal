package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CustomResponse;
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

import java.util.Optional;

@Data
@Service
@RequiredArgsConstructor
public class FavoriteService {

    private final UserRepository userRepository;
    private final FavoriteRepository favoriteRepository;

    @Transactional
    public ResponseEntity<CustomResponse> manageFavoriteUser(Integer userId, Integer favoriteUserID) {
        Optional<User> userOptional = userRepository.findById(userId);
        Optional<User> commuterOptional = userRepository.findById(favoriteUserID);

        if (userOptional.isEmpty() || commuterOptional.isEmpty()) {
            // User or commuter not found
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(CustomResponse.builder()
                            .status(HttpStatus.NOT_FOUND.value())
                            .message("User or commuter not found")
                            .build());
        }

        User user = userOptional.get();
        User commuter = commuterOptional.get();

        if (user.getId() == commuter.getId()) {
            // User cannot add themselves to favorites
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(CustomResponse.builder()
                            .status(HttpStatus.BAD_REQUEST.value())
                            .message("Cannot add yourself to favorites")
                            .build());
        }

        if (favoriteRepository.existsByUserIdAndFavoriteUserId(userId, favoriteUserID)) {
            // If already favorite, remove it
            favoriteRepository.deleteByUserIdAndFavoriteUserId(userId, favoriteUserID);
            return ResponseEntity.ok().body(CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Removed successfully")
                    .build());
        } else {
            // If not favorite, add it
            Favorite favorite = new Favorite();
            favorite.setUser(user);
            favorite.setFavoriteUser(commuter);
            favoriteRepository.save(favorite);
            return ResponseEntity.ok().body(CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Added successfully")
                    .build());
        }
    }
}