package com.graduationproject.DTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing the profile of a normal user.
 */
@Data
public class NormalProfileDTO {
    /** The phone number of the user. */
    private String phoneNumber;

    /** The full name of the user. */
    private String fullName;

    /** The URL of the user's profile photo. */
    private String profilePhotoURL;
}