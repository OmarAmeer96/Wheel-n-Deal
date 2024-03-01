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

@Service
@Data
@RequiredArgsConstructor
public class FavoriteService {

    /* In the fav part I make that the user and the commuter have thier own favs, So If the user add commuter x
    this commuter x will be added to the user's fav list but in the commuter x list it will not be shown till he
    make him fav back */
    private final UserRepository userRepository;
    private final FavoriteRepository favoriteRepository;

    public ResponseEntity<String> manageFavoriteUser(int userId, int favoriteUserID) {
        Optional<User> user = userRepository.findById(userId);
        Optional<User> commuter = userRepository.findById(favoriteUserID);
        Favorite favorite = favoriteRepository.findByUserIdAndFavoriteUserId(userId,favoriteUserID);
        if(favorite != null){
            favoriteRepository.delete(favorite);
            return ResponseEntity.ok("Removed Successfully");
        }else {
            /*
            here I created a new favorite object to hold the data because I didn't have one
            above I just tried to assign a value to this fav but in the case of null I can't do this
            */
            favorite=new Favorite();
            favorite.setUser(user.get());
            favorite.setFavoriteUser(commuter.get());
            favoriteRepository.save(favorite);
            return ResponseEntity.ok("Added Successfully");
        }
    }
}