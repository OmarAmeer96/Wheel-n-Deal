package com.graduationproject.DTOs.optDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Data Transfer Object (DTO) representing the response for OTP verification.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OtpResponseDTO {
    private OtpStatus status;
    private String message;
}