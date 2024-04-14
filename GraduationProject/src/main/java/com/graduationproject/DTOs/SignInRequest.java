package com.graduationproject.DTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing a sign-in request.
 */
@Data
public class SignInRequest {
    /** The username for signing in. */
    private String username;

    /** The password for signing in. */
    private String password;
}