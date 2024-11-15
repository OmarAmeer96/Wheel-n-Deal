package com.graduationproject.services.impl;

import com.graduationproject.DTOs.stripePaymentDTOs.ChargeUserDTO;
import com.graduationproject.entities.StripePaymentEntity;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.StripePaymentRepository;
import com.graduationproject.repositories.UserRepository;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.*;
import com.stripe.param.PaymentIntentCreateParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Service
public class StripeServiceImpl {

    @Autowired
    private StripePaymentRepository paymentRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private Environment env;

    public ResponseEntity<Object> chargeUser(ChargeUserDTO chargeUserDTO) {
        if (chargeUserDTO == null) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "ChargeUserDTO cannot be null."),
                    HttpStatus.BAD_REQUEST
            );
        }

        if (chargeUserDTO.getAmount() == null || chargeUserDTO.getStripeUserId() == null) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "Amount and Stripe User ID must be provided."),
                    HttpStatus.BAD_REQUEST
            );
        }

        String stripeApiKey = env.getProperty("stripe.api.secretKey");
        if (stripeApiKey == null) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "Stripe API key is not configured."),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }

        try {
            Stripe.apiKey = stripeApiKey;

            Long amountInCents = chargeUserDTO.getAmount() * 100;

            PaymentIntentCreateParams params = PaymentIntentCreateParams.builder()
                    .setAmount(amountInCents)
                    .setCurrency("EGP")
                    .setConfirm(true)
                    .setPaymentMethod("pm_card_visa")
                    .setAutomaticPaymentMethods(
                            PaymentIntentCreateParams.AutomaticPaymentMethods.builder()
                                    .setEnabled(true)
                                    .setAllowRedirects(PaymentIntentCreateParams.AutomaticPaymentMethods.AllowRedirects.NEVER)
                                    .build()
                    )
                    .setCustomer(chargeUserDTO.getStripeUserId())
                    .setSetupFutureUsage(PaymentIntentCreateParams.SetupFutureUsage.OFF_SESSION)
                    .build();

            PaymentIntent paymentIntent = PaymentIntent.create(params);

            User customer = userRepository.findByStripeId(chargeUserDTO.getStripeUserId());
            if (customer == null) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.NOT_FOUND.value(), "message", "User with Stripe ID " + chargeUserDTO.getStripeUserId() + " not found."),
                        HttpStatus.NOT_FOUND
                );
            }

            Long newAmount = customer.getAmount() + chargeUserDTO.getAmount();
            customer.setAmount(newAmount);
            userRepository.save(customer);

            StripePaymentEntity payment = new StripePaymentEntity();
            payment.setAmount(chargeUserDTO.getAmount());
            payment.setTimestamp(LocalDateTime.now());
            payment.setStripeUserId(chargeUserDTO.getStripeUserId());
            paymentRepository.save(payment);

            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.OK.value(), "message", "Charge completed successfully."),
                    HttpStatus.OK
            );

        } catch (StripeException e) {
            e.printStackTrace();
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "Stripe error: " + e.getMessage(), "data", e.getMessage()),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "An error occurred while processing the charge.", "data", e.getMessage()),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    public ResponseEntity<Object> getAllUserCharges(String stripeUserId) {
        if (stripeUserId == null || stripeUserId.isBlank()) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "Stripe User ID must be provided."),
                    HttpStatus.BAD_REQUEST
            );
        }

        String stripeApiKey = env.getProperty("stripe.api.secretKey");
        if (stripeApiKey == null) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "Stripe API key is not configured."),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }

        try {
            Stripe.apiKey = stripeApiKey;

            Map<String, Object> params = new HashMap<>();
            params.put("customer", stripeUserId);

            ChargeCollection charges = Charge.list(params);

            if (charges.getData().isEmpty()) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.NOT_FOUND.value(), "message", "No charges found for the specified Stripe User ID."),
                        HttpStatus.NOT_FOUND
                );
            }

            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.OK.value(), "message", "Charges retrieved successfully.", "data", charges.getData()),
                    HttpStatus.OK
            );

        } catch (StripeException e) {
            e.printStackTrace();
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "Stripe error: " + e.getMessage(), "data", e.getMessage()),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "An unexpected error occurred while retrieving charges.", "data", e.getMessage()),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

}