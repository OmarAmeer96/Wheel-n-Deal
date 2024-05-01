package com.graduationproject.DTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing reviews in a user's profile.
 */
@Data
public class ProfileReviewsDTO {
    private Integer reviewId;
    private String reviewerFullName;
    private String reviewerProfilePhotoURL;
    private int rate;
    private String comment;
}