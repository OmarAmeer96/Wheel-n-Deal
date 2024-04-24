package com.graduationproject.DTOs;

import lombok.Data;

@Data
public class ApplicantDTO {
    private Integer commuterId;
    private String commuterPhotoURL;
    private double price;
    private String fullName;
}
