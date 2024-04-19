package com.graduationproject.controllers;

import com.graduationproject.DTOs.stripePaymentDTOs.ChargeUserDTO;
import com.graduationproject.services.impl.StripeServiceImpl;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/visa-payments")
public class StripeController {

    @Autowired
    private StripeServiceImpl stripeService;

    @PostMapping("charge")
    public String charge(@RequestBody ChargeUserDTO chargeUserDTO) throws StripeException {
        return stripeService.chargeUser(chargeUserDTO);
    }

    @PostMapping("get-all-user-charges")
    public List<Charge> getAllUserCharges(@RequestParam String stripeUserId) throws StripeException {
        return stripeService.getAllUserCharges(stripeUserId);
    }
}