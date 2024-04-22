package com.graduationproject.DTOs;

import lombok.Data;

@Data
public class ReviewDTO {
    private Integer id;
    private int rate;
    private String comment;
    private int reviewerId;
    private int revieweeId;
}