package com.graduationproject.entities;

import jakarta.persistence.*;
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
    private String token;

    /** The type of the token. */
    @Enumerated(EnumType.STRING)
    private TokenType tokenType;

    /** Indicates whether the token is expired. */
    private boolean expired;

    /** Indicates whether the token is revoked. */
    private boolean revoked;

    /** The user associated with the token. */
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}