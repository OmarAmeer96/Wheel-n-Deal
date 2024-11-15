package com.graduationproject.DTOs;

import lombok.Data;

@Data
public class ProfileReviewsDTO {
    private String reviewerFullName;
    private String reviewerProfilePhotoURL;
    private Integer rate;
    private String comment;
}