package com.graduationproject.DTOs;

import com.graduationproject.entities.Gender;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

/**
 * Data Transfer Object (DTO) representing a user profile.
 */
@Data
public class UserProfileDTO {
    /** The ID of the user profile. */
    private Integer id;

    /** The full name of the user. */
    private String fullName;

    /** The gender of the user. */
    private Gender gender;

    /** The city where the user resides. */
    private String city;

    /** The profile picture of the user. */
    private MultipartFile profilePicture;

    /** The phone number of the user. */
    private String phone;

    /** The national ID of the user. */
    private String nationalId;
}