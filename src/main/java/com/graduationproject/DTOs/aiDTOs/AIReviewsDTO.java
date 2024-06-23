package com.graduationproject.DTOs.aiDTOs;

import com.graduationproject.entities.User;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AIReviewsDTO {
    private Integer id;
    private Integer rate;
    private Integer reviewer;
    private Integer reviewee;
}
