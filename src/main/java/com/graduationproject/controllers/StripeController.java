package com.graduationproject.controllers;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.stripePaymentDTOs.ChargeUserDTO;
import com.graduationproject.services.impl.StripeServiceImpl;
import com.stripe.exception.StripeException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/visa-payments")
public class StripeController {

    @Autowired
    private StripeServiceImpl stripeService;

    @PostMapping("charge")
    public CustomResponse charge(@RequestBody ChargeUserDTO chargeUserDTO) throws StripeException {
        return stripeService.chargeUser(chargeUserDTO);
    }

    @PostMapping("get-all-user-charges")
    public CustomResponse getAllUserCharges(@RequestParam String stripeUserId) throws StripeException {
        return stripeService.getAllUserCharges(stripeUserId);
    }
}