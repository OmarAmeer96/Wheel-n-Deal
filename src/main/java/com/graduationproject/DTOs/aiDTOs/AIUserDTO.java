package com.graduationproject.DTOs.aiDTOs;

import com.graduationproject.entities.Gender;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AIUserDTO {
    private Integer id;
    private String city;
    private Gender gender;
}
