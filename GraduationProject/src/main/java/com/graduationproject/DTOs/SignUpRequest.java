package com.graduationproject.DTOs;

import com.graduationproject.entities.Role;
import lombok.Data;

/**
 * Data Transfer Object (DTO) representing a sign-up request.
 */
@Data
public class SignUpRequest {
    /** The phone number for signing up. */
    private String phone;

    /** The username for signing up. */
    private String username;

    /** The password for signing up. */
    private String password;

    /** The role for the user. */
    private Role role;
}