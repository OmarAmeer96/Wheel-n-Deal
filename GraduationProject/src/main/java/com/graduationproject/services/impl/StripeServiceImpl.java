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

@Service
public class StripeServiceImpl {
    @Autowired
    private StripePaymentRepository paymentRepository;
    @Autowired
    private UserRepository userRepository;

    public String createStripeUser(CreateStripeUserRequestDTO request) throws StripeException, JsonProcessingException {
        Stripe.apiKey = "sk_test_51Of0HSDRpAtfI02p07kURFyWFuON9GhxXSEzZNxRpbVqLXc83KH0JcMjeURgkwf6UXsD9Xm7Z7sVf3g9tFC2Gdeo00fPYbS9G6";

        CustomerCreateParams customerParams = CustomerCreateParams.builder()
                .setPhone(request.getPhoneNumber())
                .setName(request.getUserName())
                .build();

        Customer customer = Customer.create(customerParams);
        Customer customerRetrieve = Customer.retrieve(customer.getId());
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.readTree(customerRetrieve.toJson());
        Map<String, String> customerDetails = new HashMap<>();
        jsonNode.fields().forEachRemaining(entry -> customerDetails.put(entry.getKey(), entry.getValue().asText()));

        User userEntity = new User();
        userEntity.setStripeId(customer.getId());
        userEntity.setPhoneNumber(request.getPhoneNumber());
        userEntity.setUserName(request.getUserName());
        userEntity.setAmount(0L);
        userRepository.save(userEntity);

        return customer.getId();
    }

    public String chargeUser(ChargeUserDTO chargeUserDTO) throws StripeException {
        Stripe.apiKey = "sk_test_51Of0HSDRpAtfI02p07kURFyWFuON9GhxXSEzZNxRpbVqLXc83KH0JcMjeURgkwf6UXsD9Xm7Z7sVf3g9tFC2Gdeo00fPYbS9G6";
        Long amountInCents = chargeUserDTO.getAmount() * 100; // Convert amount to cents

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

        PaymentIntent paymentIntent = PaymentIntent.create(params);
        User customer = userRepository.findByStripeId(chargeUserDTO.getStripeUserId());
        if (customer != null) {
            Long newAmount = customer.getAmount() + chargeUserDTO.getAmount();
            customer.setAmount(newAmount);
            userRepository.save(customer);
//             Save payment in the database
            StripePaymentEntity payment = new StripePaymentEntity();
            payment.setAmount(chargeUserDTO.getAmount());
            payment.setTimestamp(LocalDateTime.now());
            payment.setStripeUserId(chargeUserDTO.getStripeUserId());
            paymentRepository.save(payment);
        }
        return "Charge completed successfully";
    }

    public List<Charge> getAllUserCharges(String stripeUserId) throws StripeException {
        Stripe.apiKey = "sk_test_51Of0HSDRpAtfI02p07kURFyWFuON9GhxXSEzZNxRpbVqLXc83KH0JcMjeURgkwf6UXsD9Xm7Z7sVf3g9tFC2Gdeo00fPYbS9G6";
        Map<String, Object> params = new HashMap<>();
        params.put("customer", stripeUserId);
        ChargeCollection charges = Charge.list(params);
        return charges.getData();
    }
}
