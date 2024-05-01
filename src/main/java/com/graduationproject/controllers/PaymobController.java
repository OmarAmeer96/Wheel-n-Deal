package com.graduationproject.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.paymobPaymentDTOs.*;
import com.graduationproject.services.impl.PaymobServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/vodafone-payments")
public class PaymobController {

    @Autowired
    private PaymobServiceImpl paymobService;
    @Autowired
    private Environment env;


    public String getAuthToken() throws JsonProcessingException {
        String apiKey = env.getProperty("paymobKey");
        return paymobService.getAuthToken(apiKey);
    }

    public String createEcommerceOrder(@RequestBody SecondRequest request) throws JsonProcessingException {
        return paymobService.createEcommerceOrder(request);
    }

    public String sendPaymentKeyRequest(@RequestBody ThirdRequest thirdRequest) throws JsonProcessingException {
        return paymobService.sendPaymentKeyRequest(thirdRequest);
    }

    public CustomResponse processWalletPayment(@RequestBody WalletRequest walletRequest) {
        return paymobService.sendPaymentRequest(walletRequest);
    }

    @PostMapping("EWalletCharge")
    public CustomResponse EWalletCharge(@RequestBody PayRequestDTO request) throws JsonProcessingException {
        // Steps to perform EWallet charge
        // 1. Retrieve authentication token
        String apiKey = "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RVMk5qYzNMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkubWdRME9MbXo4SlRBdE5HSmFnNjJrR21DcndoZzlyTEthN3dVdHRmQnc5bnRGSlN5NEhCbTVmWV9pelBuX2tQOGh4X2lhdzdDWnYwT0M5MDZaMk41UWc=";
        String auth = paymobService.getAuthToken(apiKey);

        // 2. Calculate amount in cents and create ecommerce order
        Long amountInCents = Long.parseLong(request.getAmount()) * 100;
        String am = String.valueOf(amountInCents);
        SecondRequest requestTwo = new SecondRequest(auth, am);
        String orderId = paymobService.createEcommerceOrder(requestTwo);

        // 3. Send payment key request
        ThirdRequest requestThree = new ThirdRequest(auth, am, orderId);
        String token = paymobService.sendPaymentKeyRequest(requestThree);

        // 4. Process wallet payment
        WalletRequest walletRequest = new WalletRequest(token, request.getSource());
        CustomResponse response = paymobService.sendPaymentRequest(walletRequest);

        return response;
    }
}