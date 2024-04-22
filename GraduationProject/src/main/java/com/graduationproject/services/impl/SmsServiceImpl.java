package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.optDTOs.OtpResponseDTO;
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

@Slf4j
@Service
public class SmsServiceImpl {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private TwilioConfiguration twilioConfig;

    public CustomResponse updatePassword(String phoneNumber, String newPassword) {
        if (phoneNumber == null) {
            return CustomResponse.builder()
                    .status(400)
                    .message("Phone number is required.")
                    .build();
        }

        if (newPassword == null || newPassword.isBlank() || newPassword.length() < 6) {
            return CustomResponse.builder()
                    .status(400)
                    .message("New password must be at least 6 characters long and not empty.")
                    .build();
        }

        try {
            User user = userRepository.findByPhoneNumber(phoneNumber);

            if (user == null) {
                return CustomResponse.builder()
                        .status(404)
                        .message("User with phone number " + phoneNumber + " does not exist.")
                        .build();
            }

            user.setPassword(newPassword);
            userRepository.save(user);

            return CustomResponse.builder()
                    .status(200)
                    .message("Password updated successfully.")
                    .build();

        } catch (Exception ex) {
            return CustomResponse.builder()
                    .status(500)
                    .message("An error occurred while updating the password.")
                    .data(ex.getMessage())
                    .build();
        }
    }

    // Map to store OTPs sent to phone numbers
    Map<String, String> otpMap = new HashMap<>();

    public CustomResponse sendSMS(String phoneNumber) {
        if (phoneNumber == null || phoneNumber.isBlank()) {
            return CustomResponse.builder()
                    .status(400)
                    .message("Phone number cannot be null or empty.")
                    .build();
        }

        if (!phoneNumber.matches("^(\\+20)?01[0-2]{1}[0-9]{8}$")) {
            return CustomResponse.builder()
                    .status(400)
                    .message("Invalid phone number format. Must be a 13-digit number.")
                    .build();
        }

        try {
            PhoneNumber to = new PhoneNumber("+20" + phoneNumber);
            PhoneNumber from = new PhoneNumber(twilioConfig.getPhoneNumber());
            String otp = generateOTP();
            String otpMessage = "Dear Customer, Your OTP is " + otp + ", welcome to Wheel n' Deal family. Thank You.";

            Message message = Message.creator(to, from, otpMessage).create();

            otpMap.put(phoneNumber, otp);

            return CustomResponse.builder()
                    .status(200)
                    .message("OTP sent successfully.")
                    .data(new OtpResponseDTO(OtpStatus.DELIVERED, otpMessage))
                    .build();

        } catch (Exception e) {
            e.printStackTrace();
            return CustomResponse.builder()
                    .status(500)
                    .message("Failed to send OTP.")
                    .data(e.getMessage())
                    .build();
        }
    }

    public CustomResponse validateOtp(OtpValidationRequest otpValidationRequest) {
        if (otpValidationRequest.getPhoneNumber() == null || otpValidationRequest.getOtpNumber() == null) {
            return CustomResponse.builder()
                    .status(400)
                    .message("Phone number and OTP must be provided.")
                    .build();
        }

        String phoneNumber = otpValidationRequest.getPhoneNumber();
        String providedOtp = otpValidationRequest.getOtpNumber();

        if (!otpMap.containsKey(phoneNumber)) {
            return CustomResponse.builder()
                    .status(404)
                    .message("No OTP found for the provided phone number.")
                    .build();
        }

        String storedOtp = otpMap.get(phoneNumber);

        if (storedOtp.equals(providedOtp)) {
            try {
                updatePassword(phoneNumber, otpValidationRequest.getNewPassword());
                otpMap.remove(phoneNumber);

                return CustomResponse.builder()
                        .status(200)
                        .message("OTP is valid! Password has been updated.")
                        .build();

            } catch (Exception e) {
                return CustomResponse.builder()
                        .status(500)
                        .message("An error occurred while updating the password.")
                        .data(e.getMessage())
                        .build();
            }
        } else {
            return CustomResponse.builder()
                    .status(401)
                    .message("OTP is invalid!")
                    .build();
        }
    }

    private String generateOTP() {
        try {
            int maxOtpValue = 9999;
            int minOtpValue = 0;

            Random random = new Random();
            int randomNumber = random.nextInt((maxOtpValue - minOtpValue) + 1) + minOtpValue;

            return new DecimalFormat("0000").format(randomNumber);

        } catch (Exception e) {
            throw new RuntimeException("An error occurred while generating OTP.", e);
        }
    }
}