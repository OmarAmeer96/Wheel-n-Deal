package com.graduationproject.repositories;

import com.graduationproject.entities.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repository interface for managing favorite entities in the database.
 */
@Repository
public interface FavoriteRepository extends JpaRepository<Favorite,Integer> {

    /**
     * Finds a favorite entry by the user ID and favorite user ID.
     * @param userId The ID of the user.
     * @param favoriteUserId The ID of the favorite user.
     * @return The favorite entry matching the given user IDs, or null if not found.
     */
    Favorite findByUserIdAndFavoriteUserId(int userId, int favoriteUserId);
}