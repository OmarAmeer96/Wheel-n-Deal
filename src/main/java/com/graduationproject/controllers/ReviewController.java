package com.graduationproject.controllers;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.ReviewDTO;
import com.graduationproject.services.impl.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Controller class for handling review-related operations.
 */
@RestController
@RequestMapping("api/v1/user")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    /**
     * Endpoint for submitting or editing a review.
     * @param reviewDTO The DTO containing review details
     * @return ResponseEntity indicating the success of the operation
     */
    @PostMapping("submit-or-edit-review")
    public CustomResponse submitOrEditReview(@RequestBody ReviewDTO reviewDTO) throws Exception {
        return reviewService.submitOrEditReview(reviewDTO);
    }

    /**
     * Endpoint for deleting a review by its ID.
     * @param reviewId The ID of the review to delete
     * @return A string indicating the result of the deletion
     */
    @DeleteMapping("delete-review/{reviewId}")
    public CustomResponse deleteReview(@PathVariable int reviewId){
        return reviewService.deleteReview(reviewId);
    }
}