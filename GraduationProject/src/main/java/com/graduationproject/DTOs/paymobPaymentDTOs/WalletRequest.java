package com.graduationproject.DTOs.paymobPaymentDTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing a wallet request for Paymob payment.
 */
@Data
public class WalletRequest {
    /** The payment source. */
    private Source source;

    /** The payment token associated with the wallet. */
    private String payment_token;

    /**
     * Constructs a new WalletRequest object with the given payment token and source.
     * @param paymentToken The payment token.
     * @param source The payment source.
     */
    public WalletRequest(String paymentToken, Source source){
        this.payment_token = paymentToken;
        this.source = source;
    }
}