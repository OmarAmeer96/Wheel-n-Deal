package com.graduationproject.controllers;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.services.impl.FavoriteService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/user")
public class FavoriteController {

    private final FavoriteService favoriteService;

    @PostMapping("manageFavorites/{userId}/{favoriteUserId}")
    public CustomResponse  manageFavoriteUser(@PathVariable Integer userId, @PathVariable Integer favoriteUserId) {
        return favoriteService.manageFavoriteUser(userId, favoriteUserId);
    }
}