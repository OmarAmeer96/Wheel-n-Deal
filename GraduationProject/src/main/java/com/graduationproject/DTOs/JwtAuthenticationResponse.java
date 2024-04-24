package com.graduationproject.DTOs;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class JwtAuthenticationResponse {
    private Integer status;
    private String message;
    private Object data;
}