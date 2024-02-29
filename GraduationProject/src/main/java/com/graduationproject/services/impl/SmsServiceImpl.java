package com.graduationproject.services.impl;

import com.graduationproject.DTOs.optDTOs.OtpResponseDto;
import com.graduationproject.DTOs.optDTOs.OtpStatus;
import com.graduationproject.DTOs.optDTOs.OtpValidationRequest;
import com.graduationproject.configuration.TwilioConfiguration;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.UserRepository;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.Set;

@Service
@Slf4j
public class SmsServiceImpl {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private TwilioConfiguration twilioConfig;

    public void updatePassword(String phoneNumber, String newPassword) {
        User user = userRepository.findByPhoneNumber(phoneNumber);

        if (user != null) {
            user.setPassword(newPassword);
            userRepository.save(user);
        }
    }

    Map<String, String> otpMap = new HashMap<>();


    public OtpResponseDto sendSMS(String phoneNumber) {
        OtpResponseDto otpResponseDto;
        try {
            PhoneNumber to = new PhoneNumber(phoneNumber);//to
            PhoneNumber from = new PhoneNumber(twilioConfig.getPhoneNumber()); // from
            String otp = generateOTP();
            String otpMessage = "Dear Customer, Your OTP is " + otp + ", welcome to Wheel n' Deal family. Thank You.";
            Message message = Message
                    .creator(to, from,
                            otpMessage)
                    .create();
            otpMap.put(phoneNumber, otp);
            otpResponseDto = new OtpResponseDto(OtpStatus.DELIVERED, otpMessage);
        } catch (Exception e) {
            e.printStackTrace();
            otpResponseDto = new OtpResponseDto(OtpStatus.FAILED, e.getMessage());
        }
        return otpResponseDto;
    }

    public String validateOtp(OtpValidationRequest otpValidationRequest) {
        Set<String> keys = otpMap.keySet();
        String phoneNumber = null;
        for (String key : keys)
            phoneNumber = key;
        if (otpValidationRequest.getPhoneNumber().equals(phoneNumber)) {
            updatePassword(phoneNumber, otpValidationRequest.getNewPassword());
            otpMap.remove(phoneNumber, otpValidationRequest.getOtpNumber());
            return "OTP is valid!";
        } else {
            return "OTP is invalid!";
        }
    }

    private String generateOTP() {
        return new DecimalFormat("0000")
                .format(new Random().nextInt(9999));
    }
}

