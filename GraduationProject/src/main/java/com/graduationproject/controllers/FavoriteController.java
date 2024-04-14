package com.graduationproject.controllers;

import com.graduationproject.services.impl.FavoriteService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controller class for managing favorite users.
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/user")
public class FavoriteController {

    private final FavoriteService favoriteService;

    /**
     * Endpoint for managing favorite users.
     * @param userId The ID of the user performing the action
     * @param favoriteUserId The ID of the user being favorited or unfavorited
     * @return ResponseEntity containing the result of the operation
     */
    @PostMapping("manageFavorites/{userId}/{favoriteUserId}")
    public ResponseEntity<String> manageFavoriteUser(@PathVariable int userId, @PathVariable int favoriteUserId) {
        return favoriteService.manageFavoriteUser(userId, favoriteUserId);
    }
}