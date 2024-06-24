package com.graduationproject.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UserCountDTO {
    private String day;
    private Long count;
}