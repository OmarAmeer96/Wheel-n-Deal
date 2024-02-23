package com.graduationproject.DTOs.paymobPaymentDTOs;

import lombok.Data;

@Data
public class PayRequestDTO {
    private String amount;
    private Source source;
}
