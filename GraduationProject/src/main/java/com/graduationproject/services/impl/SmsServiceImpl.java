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
import java.util.Set;

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
                    .status(400)  // HTTP Bad Request
                    .message("Phone number is required.")
                    .build();
        }

        if (newPassword == null || newPassword.isBlank() || newPassword.length() < 6) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("New password must be at least 6 characters long and not empty.")
                    .build();
        }

        try {
            User user = userRepository.findByPhoneNumber(phoneNumber);

            if (user == null) {
                return CustomResponse.builder()
                        .status(404)  // HTTP Not Found
                        .message("User with phone number " + phoneNumber + " does not exist.")
                        .build();
            }

            user.setPassword(newPassword);
            userRepository.save(user);

            return CustomResponse.builder()
                    .status(200)  // HTTP OK
                    .message("Password updated successfully.")
                    .build();

        } catch (Exception ex) {
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("An error occurred while updating the password.")
                    .data(ex.getMessage())  // Include exception message for debugging
                    .build();
        }
    }

    // Map to store OTPs sent to phone numbers
    Map<String, String> otpMap = new HashMap<>();

    public CustomResponse sendSMS(String phoneNumber) {
        if (phoneNumber == null || phoneNumber.isBlank()) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("Phone number cannot be null or empty.")
                    .build();
        }

        // Check if the phone number is in a valid format
        if (!phoneNumber.matches("^(\\+20)?01[0-2]{1}[0-9]{8}$")) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("Invalid phone number format. Must be a 13-digit number.")
                    .build();
        }

        try {
            PhoneNumber to = new PhoneNumber("+20" + phoneNumber); // Receiver's phone number
            PhoneNumber from = new PhoneNumber(twilioConfig.getPhoneNumber()); // Twilio phone number
            String otp = generateOTP();  // Assume this generates a valid OTP
            String otpMessage = "Dear Customer, Your OTP is " + otp + ", welcome to Wheel n' Deal family. Thank You.";

            Message message = Message.creator(to, from, otpMessage).create();

            // Store OTP against the phone number in the map
            otpMap.put(phoneNumber, otp);

            return CustomResponse.builder()
                    .status(200)  // HTTP OK
                    .message("OTP sent successfully.")
                    .data(new OtpResponseDTO(OtpStatus.DELIVERED, otpMessage))
                    .build();

        } catch (Exception e) {
            e.printStackTrace();
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("Failed to send OTP.")
                    .data(e.getMessage())  // Include the exception message for debugging
                    .build();
        }
    }

    public CustomResponse validateOtp(OtpValidationRequest otpValidationRequest) {
        if (otpValidationRequest.getPhoneNumber() == null || otpValidationRequest.getOtpNumber() == null) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("Phone number and OTP must be provided.")
                    .build();
        }

        String phoneNumber = otpValidationRequest.getPhoneNumber();
        String providedOtp = otpValidationRequest.getOtpNumber();

        if (!otpMap.containsKey(phoneNumber)) {
            return CustomResponse.builder()
                    .status(404)  // HTTP Not Found
                    .message("No OTP found for the provided phone number.")
                    .build();
        }

        String storedOtp = otpMap.get(phoneNumber);

        if (storedOtp.equals(providedOtp)) {
            try {
                updatePassword(phoneNumber, otpValidationRequest.getNewPassword());
                otpMap.remove(phoneNumber);  // Remove the OTP once it's validated

                return CustomResponse.builder()
                        .status(200)  // HTTP OK
                        .message("OTP is valid! Password has been updated.")
                        .build();

            } catch (Exception e) {
                return CustomResponse.builder()
                        .status(500)  // HTTP Internal Server Error
                        .message("An error occurred while updating the password.")
                        .data(e.getMessage())  // Include exception message for debugging
                        .build();
            }
        } else {
            return CustomResponse.builder()
                    .status(401)  // HTTP Unauthorized
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