package com.graduationproject.services.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.graduationproject.DTOs.stripePaymentDTOs.ChargeUserDTO;
import com.graduationproject.DTOs.stripePaymentDTOs.CreateStripeUserRequestDTO;
import com.graduationproject.entities.StripePaymentEntity;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.StripePaymentRepository;
import com.graduationproject.repositories.UserRepository;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.*;
import com.stripe.param.CustomerCreateParams;
import com.stripe.param.CustomerFundCashBalanceParams;
import com.stripe.param.PaymentIntentCreateParams;
import com.stripe.param.PaymentSourceCollectionCreateParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service class for handling Stripe payment operations.
 */
@Service
public class StripeServiceImpl {

    @Autowired
    private StripePaymentRepository paymentRepository;
    @Autowired
    private UserRepository userRepository;

    /**
     * Creates a new Stripe user based on the provided request.
     * @param request The request containing user details
     * @return The ID of the created Stripe user
     * @throws StripeException If an error occurs during the Stripe API call
     * @throws JsonProcessingException If an error occurs during JSON processing
     */
    public String createStripeUser(CreateStripeUserRequestDTO request) throws StripeException, JsonProcessingException {
        // Set the API key for Stripe
        Stripe.apiKey = "sk_test_51Of0HSDRpAtfI02p07kURFyWFuON9GhxXSEzZNxRpbVqLXc83KH0JcMjeURgkwf6UXsD9Xm7Z7sVf3g9tFC2Gdeo00fPYbS9G6";

        // Create customer parameters
        CustomerCreateParams customerParams = CustomerCreateParams.builder()
                .setPhone(request.getPhoneNumber())
                .setName(request.getUserName())
                .build();

        // Create a new customer in Stripe
        Customer customer = Customer.create(customerParams);

        // Retrieve customer details
        Customer customerRetrieve = Customer.retrieve(customer.getId());
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.readTree(customerRetrieve.toJson());
        Map<String, String> customerDetails = new HashMap<>();
        jsonNode.fields().forEachRemaining(entry -> customerDetails.put(entry.getKey(), entry.getValue().asText()));

        // Save user details in the database
        User userEntity = new User();
        userEntity.setStripeId(customer.getId());
        userEntity.setPhoneNumber(request.getPhoneNumber());
        userEntity.setUsername(request.getUserName());
        userEntity.setAmount(0L);
        userRepository.save(userEntity);

        return customer.getId();
    }

    /**
     * Charges a user's account based on the provided details.
     * @param chargeUserDTO The DTO containing charge details
     * @return A message indicating the status of the charge operation
     * @throws StripeException If an error occurs during the Stripe API call
     */
    public String chargeUser(ChargeUserDTO chargeUserDTO) throws StripeException {
        // Set the API key for Stripe
        Stripe.apiKey = "sk_test_51Of0HSDRpAtfI02p07kURFyWFuON9GhxXSEzZNxRpbVqLXc83KH0JcMjeURgkwf6UXsD9Xm7Z7sVf3g9tFC2Gdeo00fPYbS9G6";

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

        // Update user's account balance in the database
        User customer = userRepository.findByStripeId(chargeUserDTO.getStripeUserId());
        if (customer != null) {
            Long newAmount = customer.getAmount() + chargeUserDTO.getAmount();
            customer.setAmount(newAmount);
            userRepository.save(customer);

            // Save payment details in the database
            StripePaymentEntity payment = new StripePaymentEntity();
            payment.setAmount(chargeUserDTO.getAmount());
            payment.setTimestamp(LocalDateTime.now());
            payment.setStripeUserId(chargeUserDTO.getStripeUserId());
            paymentRepository.save(payment);
        }
        return "Charge completed successfully";
    }

    /**
     * Retrieves all charges made by a specific user.
     * @param stripeUserId The ID of the Stripe user
     * @return A list of Charge objects representing the user's charges
     * @throws StripeException If an error occurs during the Stripe API call
     */
    public List<Charge> getAllUserCharges(String stripeUserId) throws StripeException {
        // Set the API key for Stripe
        Stripe.apiKey = "sk_test_51Of0HSDRpAtfI02p07kURFyWFuON9GhxXSEzZNxRpbVqLXc83KH0JcMjeURgkwf6UXsD9Xm7Z7sVf3g9tFC2Gdeo00fPYbS9G6";

        // Create parameters for listing charges
        Map<String, Object> params = new HashMap<>();
        params.put("customer", stripeUserId);

        // List charges associated with the specified customer
        ChargeCollection charges = Charge.list(params);
        return charges.getData();
    }
}