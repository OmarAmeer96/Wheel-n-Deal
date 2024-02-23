package com.graduationproject.DTOs.paymobPaymentDTOs;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class ThirdRequest {
    private String auth_token;
    private boolean delivery_needed;
    private String amount_cents;
    private String currency;
    private List<String> items;
    private int expiration;
    private String order_id;
    private BillingData billing_data;
    private int integration_id;
    public ThirdRequest(String authToken, String amountCents, String orderId) {
        this.auth_token = authToken;
        this.delivery_needed = false;
        this.amount_cents = amountCents;
        this.currency = "EGP";
        this.items = new ArrayList<>();
        this.expiration = 3600;
        this.order_id = orderId;
        this.billing_data = new BillingData();
        this.integration_id = 4502576;
    }
}
