package com.graduationproject.DTOs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Data Transfer Object (DTO) representing the response for JWT authentication.
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class JwtAuthenticationResponse {
    /** The JWT token. */
    private String token;

    /** The refresh token. */
    private String refreshToken;

    /** The status of the authentication response. */
    private boolean success;
}