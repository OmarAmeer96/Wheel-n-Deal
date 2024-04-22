package com.graduationproject.DTOs.stripePaymentDTOs;

import lombok.Data;

@Data
public class ChargeUserDTO {
    private String userName;
    private String bankName;
    private String stripeUserId;
    private Long amount;
    private String cardNumber;
    private String expiryMonth;
    private String expiryYear;
    private String cVC;
    private boolean saved;
}