package com.graduationproject.DTOs.stripePaymentDTOs;

import lombok.Data;

@Data
public class CreateStripeUserRequestDTO {
    private String phoneNumber;
    private String userName;
}
