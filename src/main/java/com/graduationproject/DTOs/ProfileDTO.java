package com.graduationproject.DTOs;

import com.graduationproject.entities.Gender;
import com.graduationproject.entities.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProfileDTO {
    private String phoneNumber;
    private String fullName;
    private String profilePhotoURL;
    private Role role;
    private Gender gender;
    private String nationalId;
    private String city;
}
