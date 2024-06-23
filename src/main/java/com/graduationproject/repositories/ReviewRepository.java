package com.graduationproject.repositories;

import com.graduationproject.DTOs.aiDTOs.AIReviewsDTO;
import com.graduationproject.entities.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface ReviewRepository extends JpaRepository<Review,Integer> {
    @Query("SELECT r FROM Review r WHERE r.reviewer.id = :reviewerId AND r.reviewee.id = :revieweeId")
    Review findByReviewerIdAndRevieweeId(@Param("reviewerId") int reviewerId, @Param("revieweeId") int revieweeId);

    @Query("SELECT new com.graduationproject.DTOs.aiDTOs.AIReviewsDTO(r.id, r.rate, r.reviewee.id, r.reviewer.id) FROM Review r")
    List<AIReviewsDTO> findAllReviewDTOs();

    List<Review> findByRevieweeId(Integer revieweeId);
}
