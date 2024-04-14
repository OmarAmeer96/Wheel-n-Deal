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
    /** The status of the OTP verification. */
    private OtpStatus status;

    /** The message associated with the OTP verification. */
    private String message;
}