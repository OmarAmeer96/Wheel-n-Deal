package com.graduationproject.DTOs.paymobPaymentDTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing a payment request for Paymob.
 */
@Data
public class PayRequestDTO {
    /** The amount of the payment. */
    private String amount;

    /** The payment source information. */
    private Source source;
}