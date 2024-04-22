package com.graduationproject.DTOs;

import com.graduationproject.entities.Gender;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class UserProfileDTO {
    private Integer id;
    private String fullName;
    private Gender gender;
    private String city;
    private MultipartFile profilePicture;
    private String phone;
    private String nationalId;
}