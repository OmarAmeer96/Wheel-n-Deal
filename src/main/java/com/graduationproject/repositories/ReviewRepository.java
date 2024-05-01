package com.graduationproject.repositories;

import com.graduationproject.entities.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


@Repository
public interface ReviewRepository extends JpaRepository<Review,Integer> {
    @Query("SELECT r FROM Review r WHERE r.reviewer.id = :reviewerId AND r.reviewee.id = :revieweeId")
    Review findByReviewerIdAndRevieweeId(@Param("reviewerId") int reviewerId, @Param("revieweeId") int revieweeId);
}
