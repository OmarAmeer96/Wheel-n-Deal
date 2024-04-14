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
    /** The new password to set after successful OTP validation. */
    private String newPassword;

    /** The phone number associated with the OTP. */
    private String phoneNumber;

    /** The OTP number to be validated. */
    private String otpNumber;
}