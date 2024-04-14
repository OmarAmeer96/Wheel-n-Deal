package com.graduationproject.repositories;

import com.graduationproject.entities.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 * Repository interface for managing review entities in the database.
 */
@Repository
public interface ReviewRepository extends JpaRepository<Review,Integer> {

    /**
     * Finds a review by the reviewer ID and reviewee ID.
     * @param reviewerId The ID of the reviewer.
     * @param revieweeId The ID of the reviewee.
     * @return The review matching the given reviewer ID and reviewee ID, or null if not found.
     */
    @Query("SELECT r FROM Review r WHERE r.reviewer.id = :reviewerId AND r.reviewee.id = :revieweeId")
    Review findByReviewerIdAndRevieweeId(@Param("reviewerId") int reviewerId, @Param("revieweeId") int revieweeId);
}
