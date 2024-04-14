package com.graduationproject.DTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing reviews in a user's profile.
 */
@Data
public class ProfileReviewsDTO {
    /** The full name of the reviewer. */
    private String reviewerFullName;

    /** The URL of the reviewer's profile photo. */
    private String reviewerProfilePhotoURL;

    /** The rate given by the reviewer. */
    private int rate;

    /** The comment provided by the reviewer. */
    private String comment;
}