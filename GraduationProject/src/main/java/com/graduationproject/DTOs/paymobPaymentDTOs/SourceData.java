package com.graduationproject.DTOs.paymobPaymentDTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing the source data for Paymob payment.
 */
@Data
public class SourceData {
    /** The type of the source data. */
    private String type;

    /** The phone number associated with the source data. */
    private String phone_number;

    /** The owner name associated with the source data. */
    private String owner_name;

    /** The sub-type of the source data. */
    private String sub_type;

    /** The PAN (Primary Account Number) associated with the source data. */
    private String pan;
}