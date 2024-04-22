package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CustomResponse;
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
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StripeServiceImpl {

    @Autowired
    private StripePaymentRepository paymentRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private Environment env;

    public CustomResponse chargeUser(ChargeUserDTO chargeUserDTO) {
        if (chargeUserDTO == null) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("ChargeUserDTO cannot be null.")
                    .build();
        }

        if (chargeUserDTO.getAmount() == null || chargeUserDTO.getStripeUserId() == null) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("Amount and Stripe User ID must be provided.")
                    .build();
        }

        // Set the API key for Stripe
        String stripeApiKey = env.getProperty("stripe.api.secretKey");
        if (stripeApiKey == null) {
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("Stripe API key is not configured.")
                    .build();
        }

        try {
            Stripe.apiKey = stripeApiKey;

            // Convert amount to cents
            Long amountInCents = chargeUserDTO.getAmount() * 100;

            // Create payment intent parameters
            PaymentIntentCreateParams params =
                    PaymentIntentCreateParams.builder()
                            .setAmount(amountInCents)
                            .setCurrency("EGP")
                            .setConfirm(true)
                            .setPaymentMethod("pm_card_visa")
                            .setAutomaticPaymentMethods(
                                    PaymentIntentCreateParams.AutomaticPaymentMethods.builder()
                                            .setEnabled(true)
                                            .setAllowRedirects(
                                                    PaymentIntentCreateParams.AutomaticPaymentMethods.AllowRedirects.NEVER
                                            )
                                            .build()
                            )
                            .setCustomer(chargeUserDTO.getStripeUserId())
                            .setSetupFutureUsage(PaymentIntentCreateParams.SetupFutureUsage.OFF_SESSION)
                            .build();

            // Create a payment intent in Stripe
            PaymentIntent paymentIntent = PaymentIntent.create(params);

            // Find the user in the database by Stripe ID
            User customer = userRepository.findByStripeId(chargeUserDTO.getStripeUserId());
            if (customer == null) {
                return CustomResponse.builder()
                        .status(404)  // HTTP Not Found
                        .message("User with Stripe ID " + chargeUserDTO.getStripeUserId() + " not found.")
                        .build();
            }

            // Update user's account balance
            Long newAmount = customer.getAmount() + chargeUserDTO.getAmount();
            customer.setAmount(newAmount);
            userRepository.save(customer);  // Save the updated user

            // Save payment details in the database
            StripePaymentEntity payment = new StripePaymentEntity();
            payment.setAmount(chargeUserDTO.getAmount());
            payment.setTimestamp(LocalDateTime.now());
            payment.setStripeUserId(chargeUserDTO.getStripeUserId());
            paymentRepository.save(payment);  // Save the payment information

            return CustomResponse.builder()
                    .status(200)  // HTTP OK
                    .message("Charge completed successfully.")
                    .build();

        } catch (StripeException e) {
            e.printStackTrace();
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("Stripe error: " + e.getMessage())
                    .data(e.getMessage())
                    .build();
        } catch (Exception e) {
            e.printStackTrace();
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("An error occurred while processing the charge.")
                    .data(e.getMessage())
                    .build();
        }
    }

    public CustomResponse getAllUserCharges(String stripeUserId) {
        if (stripeUserId == null || stripeUserId.isBlank()) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("Stripe User ID must be provided.")
                    .build();
        }

        // Set the API key for Stripe
        String stripeApiKey = env.getProperty("stripe.api.secretKey");
        if (stripeApiKey == null) {
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("Stripe API key is not configured.")
                    .build();
        }

        try {
            Stripe.apiKey = stripeApiKey;

            // Create parameters for listing charges
            Map<String, Object> params = new HashMap<>();
            params.put("customer", stripeUserId);

            // List charges associated with the specified customer
            ChargeCollection charges = Charge.list(params);

            if (charges.getData().isEmpty()) {
                return CustomResponse.builder()
                        .status(404)  // HTTP Not Found
                        .message("No charges found for the specified Stripe User ID.")
                        .build();
            }

            return CustomResponse.builder()
                    .status(200)  // HTTP OK
                    .message("Charges retrieved successfully.")
                    .data(charges.getData())  // Include the list of charges
                    .build();

        } catch (StripeException e) {
            e.printStackTrace();
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("Stripe error: " + e.getMessage())
                    .data(e.getMessage())  // Include the exception message for debugging
                    .build();
        } catch (Exception e) {
            e.printStackTrace();
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("An unexpected error occurred while retrieving charges.")
                    .data(e.getMessage())
                    .build();
        }
    }
}