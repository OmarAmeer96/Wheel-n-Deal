package com.graduationproject.repositories;

import com.graduationproject.entities.Favorite;
import com.graduationproject.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FavoriteRepository extends JpaRepository<Favorite,Integer> {

    Favorite findByUserIdAndFavoriteUserId(int userId, int favoriteUserId);
    List<Favorite> findByUser(User user);

    boolean existsByUserIdAndFavoriteUserId(Integer userId, Integer favoriteUserID);

    void deleteByUserIdAndFavoriteUserId(Integer userId, Integer favoriteUserID);
}