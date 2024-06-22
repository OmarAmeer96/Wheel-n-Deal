package com.graduationproject.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class OrderCountDTO {
    private String date;
    private Long count;
}
