package com.graduationproject.DTOs.aiDTOs;

import com.graduationproject.entities.User;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AIReviewsDTO {
    private int id;
    private int rate;
    private User reviewer;
    private User reviewee;
}
