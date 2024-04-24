package com.graduationproject.DTOs.optDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Data Transfer Object (DTO) representing the request for OTP validation.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OtpValidationRequest {
    private String newPassword;

    private String phoneNumber;

    private String otpNumber;
}