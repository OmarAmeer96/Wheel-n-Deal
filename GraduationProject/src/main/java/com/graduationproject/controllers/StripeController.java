package com.graduationproject.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.graduationproject.DTOs.stripePaymentDTOs.ChargeUserDTO;
import com.graduationproject.DTOs.stripePaymentDTOs.CreateStripeUserRequestDTO;
import com.graduationproject.services.impl.StripeServiceImpl;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller class for handling Stripe payment operations.
 */
@RestController
@RequestMapping("api/v1/visa-payments")
public class StripeController {

    @Autowired
    private StripeServiceImpl stripeService;

    /**
     * Endpoint for charging a user's card via Stripe.
     * @param chargeUserDTO The DTO containing charge details
     * @return A string indicating the result of the charge operation
     * @throws StripeException If an error occurs during the charging process
     */
    @PostMapping("charge")
    public String charge(@RequestBody ChargeUserDTO chargeUserDTO) throws StripeException {
        return stripeService.chargeUser(chargeUserDTO);
    }

    /**
     * Endpoint for retrieving all charges associated with a user from Stripe.
     * @param stripeUserId The Stripe user ID
     * @return A list of Charge objects representing the user's charges
     * @throws StripeException If an error occurs during the retrieval process
     */
    @PostMapping("get-all-user-charges")
    public List<Charge> getAllUserCharges(@RequestParam String stripeUserId) throws StripeException {
        return stripeService.getAllUserCharges(stripeUserId);
    }
}