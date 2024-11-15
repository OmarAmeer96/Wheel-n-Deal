package com.graduationproject.controllers;

import com.graduationproject.DTOs.ReviewDTO;
import com.graduationproject.services.impl.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/user")
public class ReviewController {

    private final ReviewService reviewService;

    @PostMapping("submit-or-edit-review")
    public ResponseEntity<?> submitOrEditReview(@RequestBody ReviewDTO reviewDTO){
        return reviewService.submitOrEditReview(reviewDTO);
    }

    @DeleteMapping("delete-review/{reviewId}")
    public ResponseEntity<?> deleteReview(@PathVariable int reviewId){
        return reviewService.deleteReview(reviewId);
    }

}