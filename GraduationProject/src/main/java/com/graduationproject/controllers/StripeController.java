package com.graduationproject.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.graduationproject.DTOs.stripePaymentDTOs.ChargeUserDTO;
import com.graduationproject.DTOs.stripePaymentDTOs.CreateStripeUserRequestDTO;
import com.graduationproject.services.impl.StripeServiceImpl;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("api/v1/visa-payments")
public class StripeController {

    @Autowired
    private StripeServiceImpl stripeService;

    @PostMapping("/create-stripe-user")
    public String createStripeUser(@RequestParam CreateStripeUserRequestDTO request) throws StripeException, JsonProcessingException {
        return stripeService.createStripeUser(request);
    }

    @PostMapping("/charge")
    public String charge(@RequestParam ChargeUserDTO chargeUserDTO) throws StripeException {
        return stripeService.chargeUser(chargeUserDTO);
    }

    @PostMapping("/get-all-user-charges")
    public List<Charge> getAllUserCharges(@RequestParam String stripeUserId) throws StripeException {
        return stripeService.getAllUserCharges(stripeUserId);
    }
}
