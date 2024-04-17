package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Represents a token entity in the application.
 */
@Data
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Token {
    /** The unique identifier for the token. */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /** The token string. */
    @NotNull(message = "Token string must not be null")
    @Size(min = 32, max = 128, message = "Token string must be between 32 and 128 characters long")
    private String token;

    /** The type of the token. */
    @Enumerated(EnumType.STRING)
    @NotNull(message = "Token type must not be null")
    private TokenType tokenType;

    /** Indicates whether the token is expired. */
    private boolean expired;

    /** Indicates whether the token is revoked. */
    private boolean revoked;

    /** The user associated with the token. */
    @ManyToOne
    @JoinColumn(name = "user_id")
    @NotNull(message = "User must not be null")
    private User user;
}