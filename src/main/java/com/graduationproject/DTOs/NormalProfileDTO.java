package com.graduationproject.DTOs;

import com.graduationproject.entities.Role;
import lombok.Data;

/**
 * Data Transfer Object (DTO) representing the profile of a normal user.
 */
@Data
public class NormalProfileDTO {
    private String phoneNumber;
    private String fullName;
    private String profilePhotoURL;
    private Role role;
}