package com.graduationproject.DTOs;

import lombok.*;

import java.util.Map;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class JwtAuthenticationResponse {
    private Integer status;
    private String message;
    private Map<String, String> data;
}