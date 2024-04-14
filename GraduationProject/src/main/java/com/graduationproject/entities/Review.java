package com.graduationproject.entities;

import jakarta.persistence.*;
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
    private int id;

    /** The rating given in the review. */
    private int rate;

    /** The comment associated with the review. */
    private String comment;

    /** The user who wrote the review. */
    @ManyToOne
    @JoinColumn(name = "reviewer_id")
    private User reviewer;

    /** The user who received the review. */
    @ManyToOne
    @JoinColumn(name = "reviewee_id")
    private User reviewee;
}