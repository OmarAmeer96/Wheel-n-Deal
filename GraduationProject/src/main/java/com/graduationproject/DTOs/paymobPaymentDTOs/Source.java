package com.graduationproject.DTOs.paymobPaymentDTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing the payment source.
 */
@Data
public class Source {
    /** The identifier of the source. */
    private String identifier = "01010101010";

    /** The subtype of the source. */
    private String subtype = "WALLET";
}