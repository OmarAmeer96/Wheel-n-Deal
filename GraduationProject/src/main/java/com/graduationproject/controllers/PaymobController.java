package com.graduationproject.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.graduationproject.DTOs.paymobPaymentDTOs.*;
import com.graduationproject.services.impl.PaymobServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/vodafone-payments")
public class PaymobController {
    @Autowired
    private PaymobServiceImpl paymobService;

    public String getAuthToken() throws JsonProcessingException {
        String apiKey = "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RVMk5qYzNMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkubWdRME9MbXo4SlRBdE5HSmFnNjJrR21DcndoZzlyTEthN3dVdHRmQnc5bnRGSlN5NEhCbTVmWV9pelBuX2tQOGh4X2lhdzdDWnYwT0M5MDZaMk41UWc=";
        return paymobService.getAuthToken(apiKey);
    }

    public String createEcommerceOrder(@RequestBody SecondRequest request) throws JsonProcessingException {
        return paymobService.createEcommerceOrder(request);
    }

    public String sendPaymentKeyRequest(@RequestBody ThirdRequest thirdRequest) throws JsonProcessingException {
        return paymobService.sendPaymentKeyRequest(thirdRequest);
    }

    public PayResponseDTO processWalletPayment(@RequestBody WalletRequest walletRequest) {
        return paymobService.sendPaymentRequest(walletRequest);
    }

    @PostMapping("EWalletCharge")
    public PayResponseDTO EWalletCharge(@RequestBody PayRequestDTO request) throws JsonProcessingException {
        // 1
        String apiKey = "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RVMk5qYzNMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkubWdRME9MbXo4SlRBdE5HSmFnNjJrR21DcndoZzlyTEthN3dVdHRmQnc5bnRGSlN5NEhCbTVmWV9pelBuX2tQOGh4X2lhdzdDWnYwT0M5MDZaMk41UWc=";
        String auth = paymobService.getAuthToken(apiKey);
        // 2
        Long amountInCents = Long.parseLong(request.getAmount()) * 100;
        String am = String.valueOf(amountInCents);
        SecondRequest requestTwo = new SecondRequest(auth, am);
        String orderId = paymobService.createEcommerceOrder(requestTwo);
        // 3
        ThirdRequest requestThree = new ThirdRequest(auth, am, orderId);
        String token = paymobService.sendPaymentKeyRequest(requestThree);
        // 4
        WalletRequest walletRequest = new WalletRequest(token, request.getSource());
        PayResponseDTO response = paymobService.sendPaymentRequest(walletRequest);

        return response;
    }
}
