package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Token {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank
    @NotNull(message = "Token string must not be null")
    @Size(min = 32, max = 128, message = "Token string must be between 32 and 128 characters long")
    private String token;

    @Enumerated(EnumType.STRING)
    @NotNull(message = "Token type must not be null")
    private TokenType tokenType;

    private boolean expired;

    private boolean revoked;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @NotNull(message = "User must not be null")
    private User user;
}