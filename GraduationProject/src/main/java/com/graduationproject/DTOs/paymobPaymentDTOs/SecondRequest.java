package com.graduationproject.DTOs.paymobPaymentDTOs;

import lombok.Data;

import java.util.ArrayList;

/**
 * Data Transfer Object (DTO) representing a second request for Paymob payment.
 */
@Data
public class SecondRequest {
     /** The authentication token for the request. */
     private String auth_token;

     /** Indicates whether delivery is needed. */
     private boolean delivery_needed;

     /** The amount of the payment in cents. */
     private String amount_cents;

     /** The currency of the payment. */
     private String currency;

     /** The list of items for the payment. */
     private ArrayList<String> items;

     /**
      * Constructs a new SecondRequest object with the given authentication token and amount in cents.
      * @param authToken The authentication token.
      * @param amount_cents The amount of the payment in cents.
      */
     public SecondRequest(String authToken, String amount_cents) {
          this.auth_token = authToken;
          this.delivery_needed = false;
          this.amount_cents = amount_cents;
          this.currency = "EGP";
          this.items = new ArrayList<>();
     }
}