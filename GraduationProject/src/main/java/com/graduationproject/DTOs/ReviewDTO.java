package com.graduationproject.DTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing a review.
 */
@Data
public class ReviewDTO {
    /** The ID of the review. */
    private Integer id;

    /** The rating given in the review. */
    private int rate;

    /** The comment provided in the review. */
    private String comment;

    /** The ID of the reviewer. */
    private int reviewerId;

    /** The ID of the reviewee. */
    private int revieweeId;
}