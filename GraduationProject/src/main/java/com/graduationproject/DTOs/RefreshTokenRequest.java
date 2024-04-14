package com.graduationproject.DTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing a request to refresh a token.
 */
@Data
public class RefreshTokenRequest {
    /** The token to be refreshed. */
    private String token;
}