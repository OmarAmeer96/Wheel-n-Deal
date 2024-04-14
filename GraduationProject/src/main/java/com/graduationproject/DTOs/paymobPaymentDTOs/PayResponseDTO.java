package com.graduationproject.DTOs.paymobPaymentDTOs;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

/**
 * Data Transfer Object (DTO) representing a payment response from Paymob.
 */
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class PayResponseDTO {
    /** The unique identifier for the payment. */
    private Long id;

    /** Indicates whether the payment is pending. */
    private boolean pending;

    /** The amount of the payment in cents. */
    private Long amount_cents;

    /** The currency of the payment. */
    private String currency;

    /** The source data of the payment. */
    private SourceData source_data;
}