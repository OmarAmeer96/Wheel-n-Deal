package com.graduationproject.repositories;

import com.graduationproject.entities.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FavoriteRepository extends JpaRepository<Favorite,Integer> {
    Favorite findByUserIdAndFavoriteUserId(int userId, int favoriteUserId);
}
