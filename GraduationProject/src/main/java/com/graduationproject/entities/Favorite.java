package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;

/**
 * Represents a favorite entity in the application.
 */
@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
public class Favorite {
    /** The unique identifier for the favorite entry. */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /** The user who favorited another user. */
    @ManyToOne
    @JoinColumn(name = "user_id")
    @NotNull(message = "User must not be null")
    private User user;

    /** The user who is favorited by another user. */
    @ManyToOne
    @JoinColumn(name = "favorite_user_id")
    @NotNull(message = "Favorite user must not be null")
    private User favoriteUser;
}