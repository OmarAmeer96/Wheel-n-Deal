package com.graduationproject.DTOs;

import lombok.Data;

@Data
public class ReviewDTO {
    private Integer id;
    private Integer rate;
    private String comment;
    private Integer reviewerId;
    private Integer revieweeId;
}