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
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.Set;

/**
 * Service class for handling SMS-related operations, such as sending OTP messages and updating passwords.
 */
@Slf4j
@Service
public class SmsServiceImpl {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private TwilioConfiguration twilioConfig;

    /**
     * Updates the password of a user associated with the provided phone number.
     * @param phoneNumber The phone number of the user whose password needs to be updated
     * @param newPassword The new password to be set for the user
     */
    public void updatePassword(String phoneNumber, String newPassword) {
        User user = userRepository.findByPhoneNumber(phoneNumber);
        if (user != null) {
            user.setPassword(newPassword);
            userRepository.save(user);
        }
    }

    // Map to store OTPs sent to phone numbers
    Map<String, String> otpMap = new HashMap<>();

    /**
     * Sends an OTP message to the provided phone number.
     * @param phoneNumber The phone number to which the OTP message will be sent
     * @return An OtpResponseDTO indicating the status of the OTP message delivery
     */
    public OtpResponseDTO sendSMS(String phoneNumber) {
        OtpResponseDTO otpResponseDto;
        try {
            PhoneNumber to = new PhoneNumber("+2"+phoneNumber); // Receiver's phone number
            PhoneNumber from = new PhoneNumber(twilioConfig.getPhoneNumber()); // Twilio phone number
            String otp = generateOTP();
            String otpMessage = "Dear Customer, Your OTP is " + otp + ", welcome to Wheel n' Deal family. Thank You.";
            Message message = Message
                    .creator(to, from, otpMessage)
                    .create();
            otpMap.put(phoneNumber, otp);
            otpResponseDto = new OtpResponseDTO(OtpStatus.DELIVERED, otpMessage);
        } catch (Exception e) {
            e.printStackTrace();
            otpResponseDto = new OtpResponseDTO(OtpStatus.FAILED, e.getMessage());
        }
        return otpResponseDto;
    }

    /**
     * Validates an OTP provided by the user.
     * @param otpValidationRequest The OtpValidationRequest containing OTP and phone number for validation
     * @return A message indicating the validation status of the OTP
     */
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

    /**
     * Generates a random OTP.
     * @return The generated OTP as a string
     */
    private String generateOTP() {
        return new DecimalFormat("0000").format(new Random().nextInt(9999));
    }
}