package com.graduationproject.DTOs.paymobPaymentDTOs;

import lombok.Data;
import java.util.ArrayList;

@Data
public class SecondRequest {
     private String auth_token;
     private boolean delivery_needed;
     private String amount_cents;
     private String currency;
     private ArrayList<String> items;

     public SecondRequest(String authToken, String amount_cents) {
          this.auth_token = authToken;
          this.delivery_needed = false;
          this.amount_cents = amount_cents;
          this.currency = "EGP";
          this.items = new ArrayList<>();
     }
}
