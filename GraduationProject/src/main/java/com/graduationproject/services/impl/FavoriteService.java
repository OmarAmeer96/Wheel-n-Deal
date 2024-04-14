package com.graduationproject.services.impl;

import com.graduationproject.entities.Favorite;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.FavoriteRepository;
import com.graduationproject.repositories.UserRepository;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

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

    /**
     * Manages adding or removing a user from favorites.
     * @param userId The ID of the user
     * @param favoriteUserID The ID of the user to be added or removed from favorites
     * @return Response indicating the success of the operation
     */

    /* In the fav part I make that the user and the commuter have thier own favs,
    So If the user add commuter x this commuter x will be added to the user's fav list
    but in the commuter x list it will not be shown till he makes him fav back */
    public ResponseEntity<String> manageFavoriteUser(int userId, int favoriteUserID) {
        Optional<User> user = userRepository.findById(userId);
        Optional<User> commuter = userRepository.findById(favoriteUserID);
        Favorite favorite = favoriteRepository.findByUserIdAndFavoriteUserId(userId, favoriteUserID);
        if (favorite != null) {
            favoriteRepository.delete(favorite);
            return ResponseEntity.ok("Removed Successfully");
        } else {
            // Create a new favorite object to hold the data if it doesn't exist
            favorite = new Favorite();
            favorite.setUser(user.get());
            favorite.setFavoriteUser(commuter.get());
            favoriteRepository.save(favorite);
            return ResponseEntity.ok("Added Successfully");
        }
    }
}