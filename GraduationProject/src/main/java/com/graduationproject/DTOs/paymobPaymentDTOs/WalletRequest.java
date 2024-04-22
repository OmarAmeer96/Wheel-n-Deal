package com.graduationproject.DTOs.paymobPaymentDTOs;

import lombok.Data;

@Data
public class WalletRequest {
    private Source source;
    private String payment_token;

    public WalletRequest(String paymentToken, Source source){
        this.payment_token = paymentToken;
        this.source = source;
    }
}