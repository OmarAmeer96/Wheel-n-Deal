package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Represents a review entity in the application.
 */
@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
public class Review {
    /** The unique identifier for the review. */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /** The rating given in the review. */
    @Min(value = 1, message = "Rating must be at least 1")
    @Max(value = 5, message = "Rating must be at most 5")
    private Integer rate;

    /** The comment associated with the review. */
    @Size(max = 255, message = "Comment length must be at most 255 characters")
    private String comment;

    /** The user who wrote the review. */
    @ManyToOne
    @JoinColumn(name = "reviewer_id")
    @NotNull(message = "Reviewer must not be null")
    private User reviewer;

    /** The user who received the review. */
    @ManyToOne
    @JoinColumn(name = "reviewee_id")
    @NotNull(message = "Reviewee must not be null")
    private User reviewee;
}