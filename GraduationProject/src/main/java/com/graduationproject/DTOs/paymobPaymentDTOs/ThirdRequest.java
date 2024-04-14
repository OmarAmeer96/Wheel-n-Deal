package com.graduationproject.DTOs.paymobPaymentDTOs;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * Data Transfer Object (DTO) representing a third request for Paymob payment.
 */
@Data
public class ThirdRequest {
    /** The authentication token for the request. */
    private String auth_token;

    /** Indicates whether delivery is needed. */
    private boolean delivery_needed;

    /** The amount of the payment in cents. */
    private String amount_cents;

    /** The currency of the payment. */
    private String currency;

    /** The list of items for the payment. */
    private List<String> items;

    /** The expiration time of the payment request. */
    private int expiration;

    /** The order ID associated with the payment request. */
    private String order_id;

    /** The billing data for the payment. */
    private BillingData billing_data;

    /** The integration ID for the payment. */
    private int integration_id;

    /**
     * Constructs a new ThirdRequest object with the given authentication token, amount in cents, and order ID.
     * @param authToken The authentication token.
     * @param amountCents The amount of the payment in cents.
     * @param orderId The order ID associated with the payment request.
     */
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