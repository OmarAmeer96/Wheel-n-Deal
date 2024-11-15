package com.graduationproject.services.impl;

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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
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
    @Autowired
    private PasswordEncoder passwordEncoder;

    public ResponseEntity<Object> forgetPassword(String phoneNumber, String newPassword) {
        if (phoneNumber != null) {
            phoneNumber = phoneNumber.trim();
        }

        if (phoneNumber == null || phoneNumber.isBlank()) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "Phone number is required."),
                    HttpStatus.BAD_REQUEST
            );
        }

        if (newPassword == null || newPassword.isBlank() || newPassword.length() < 6) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "New password must be at least 6 characters long and not empty."),
                    HttpStatus.BAD_REQUEST
            );
        }

        try {
            // Search for user by phone number (assuming phone number is prefixed with country code)
            User user = userRepository.findByPhoneNumber("+20" + phoneNumber);

            if (user == null) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.NOT_FOUND.value(), "message", "User with phone number " + "+20" + phoneNumber + " does not exist."),
                        HttpStatus.NOT_FOUND
                );
            }

            user.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(user);

            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.OK.value(), "message", "Password updated successfully."),
                    HttpStatus.OK
            );

        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "An error occurred while updating the password.", "data", ex.getMessage()),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    // Map to store OTPs sent to phone numbers
    Map<String, String> otpMap = new HashMap<>();

    public ResponseEntity<Object> sendSMS(String phoneNumber) {
        if (phoneNumber == null || phoneNumber.isBlank()) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "Phone number cannot be null or empty."),
                    HttpStatus.BAD_REQUEST
            );
        }

        try {
            // Format the phone number and initialize Twilio phone number
            PhoneNumber to = new PhoneNumber("+20" + phoneNumber);
            PhoneNumber from = new PhoneNumber(twilioConfig.getPhoneNumber());

            if (from == null || twilioConfig.getPhoneNumber().isBlank()) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "Twilio phone number is not configured."),
                        HttpStatus.INTERNAL_SERVER_ERROR
                );
            }

            // Generate OTP
            String otp = generateOTP();
            String otpMessage = "Dear Customer, Your OTP is " + otp + ", welcome to Wheel n' Deal family. Thank You.";

            // Send the OTP via Twilio
            Message message = Message.creator(to, from, otpMessage).create();

            // Store OTP in a map for verification
            otpMap.put(phoneNumber, otp);

            // Respond with success
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.OK.value(), "message", "OTP sent successfully.", "data", new OtpResponseDTO(OtpStatus.DELIVERED, otpMessage)),
                    HttpStatus.OK
            );

        } catch (IllegalArgumentException e) {
            // Handle invalid phone number format (Twilio-specific)
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "Invalid phone number format."),
                    HttpStatus.BAD_REQUEST
            );
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "Failed to send OTP.", "data", e.getMessage()),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    public ResponseEntity<Object> validateOtp(OtpValidationRequest otpValidationRequest) {
        if (otpValidationRequest.getPhoneNumber() == null || otpValidationRequest.getOtpNumber() == null) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "Phone number and OTP must be provided."),
                    HttpStatus.BAD_REQUEST
            );
        }

        String phoneNumber = otpValidationRequest.getPhoneNumber();
        String providedOtp = otpValidationRequest.getOtpNumber();

        // Check if OTP exists for the provided phone number
        if (!otpMap.containsKey(phoneNumber)) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.NOT_FOUND.value(), "message", "No OTP found for the provided phone number."),
                    HttpStatus.NOT_FOUND
            );
        }

        String storedOtp = otpMap.get(phoneNumber);

        // Validate OTP
        if (storedOtp.equals(providedOtp)) {
            try {
                // Remove OTP after successful validation
                otpMap.remove(phoneNumber);

                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.OK.value(), "message", "OTP is valid!"),
                        HttpStatus.OK
                );
            } catch (Exception e) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "An error occurred while validating OTP.", "data", e.getMessage()),
                        HttpStatus.INTERNAL_SERVER_ERROR
                );
            }
        } else {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.UNAUTHORIZED.value(), "message", "OTP is invalid!"),
                    HttpStatus.UNAUTHORIZED
            );
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