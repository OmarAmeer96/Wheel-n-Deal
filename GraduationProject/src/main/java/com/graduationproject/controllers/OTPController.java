package com.graduationproject.controllers;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.optDTOs.OtpResponseDTO;
import com.graduationproject.DTOs.optDTOs.OtpValidationRequest;
import com.graduationproject.services.impl.SmsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * Controller class for handling OTP (One-Time Password) related operations.
 */
@RestController
@CrossOrigin
@RequestMapping("api/v1/OTP")
public class OTPController {

    @Autowired
    private SmsServiceImpl smsService;

    /**
     * Endpoint for sending OTP to a phone number.
     * @param phoneNumber The phone number to which OTP will be sent
     * @return OtpResponseDTO containing the status of the OTP sending operation
     */
    @PostMapping("send-otp")
    public CustomResponse sendOtp(@RequestParam String phoneNumber) {
        return smsService.sendSMS(phoneNumber);
    }

    /**
     * Endpoint for validating OTP.
     * @param otpValidationRequest DTO containing OTP validation details
     * @return String indicating the result of the OTP validation
     */
    @PostMapping("validate-otp")
    public CustomResponse validateOtp(@RequestBody OtpValidationRequest otpValidationRequest) {
        return smsService.validateOtp(otpValidationRequest);
    }
}