package com.graduationproject.DTOs.optDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OtpValidationRequest {
    private String newPassword;
    private String phoneNumber;
    private String otpNumber;
}
