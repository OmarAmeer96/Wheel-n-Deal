package com.graduationproject.DTOs;

import com.graduationproject.entities.Gender;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommuterTripDTO {
    private Integer commuterId;
    private String city;
    private Gender gender;
    private double avgRate; // New field for total rate
    private String movingFrom;
    private String goesTo;
}
