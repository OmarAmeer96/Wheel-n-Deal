package com.graduationproject.controllers;

import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/payment")
public class PaymentController {
    @PostMapping("/charge")
    public String charge(@RequestParam Integer userId, @RequestParam Long amount) {
        try {
            Long finalAmount = 100L * amount;
            PaymentIntentCreateParams params =
                    PaymentIntentCreateParams.builder()
                            .setAmount(finalAmount)
                            .setCurrency("egp")
                            .setPaymentMethod("pm_card_visa")
                            .build();
            PaymentIntent paymentIntent = PaymentIntent.create(params);
            return "PaymentIntent created with ID: " + paymentIntent.getId();
        } catch (StripeException e) {
            return "Error creating PaymentIntent: " + e.getMessage();
        } catch (Exception e) {
            return "Unexpected error: " + e.getMessage();
        }
    }
}
