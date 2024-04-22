package com.graduationproject.controllers;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.optDTOs.OtpResponseDTO;
import com.graduationproject.DTOs.optDTOs.OtpValidationRequest;
import com.graduationproject.services.impl.SmsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("api/v1/OTP")
public class OTPController {

    @Autowired
    private SmsServiceImpl smsService;

    @PostMapping("send-otp")
    public CustomResponse sendOtp(@RequestParam String phoneNumber) {
        return smsService.sendSMS(phoneNumber);
    }

    @PostMapping("validate-otp")
    public CustomResponse validateOtp(@RequestBody OtpValidationRequest otpValidationRequest) {
        return smsService.validateOtp(otpValidationRequest);
    }
}