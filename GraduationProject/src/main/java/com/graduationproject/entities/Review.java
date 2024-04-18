package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Min(value = 1, message = "Rating must be at least 1")
    @Max(value = 5, message = "Rating must be at most 5")
    private Integer rate;

    @NotBlank
    @Size(max = 255, message = "Comment length must be at most 255 characters")
    private String comment;

    @ManyToOne
    @JoinColumn(name = "reviewer_id")
    @NotNull(message = "Reviewer must not be null")
    private User reviewer;

    @ManyToOne
    @JoinColumn(name = "reviewee_id")
    @NotNull(message = "Reviewee must not be null")
    private User reviewee;
}