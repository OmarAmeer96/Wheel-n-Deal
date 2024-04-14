package com.graduationproject.DTOs.stripePaymentDTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing a request to create a Stripe user.
 */
@Data
public class CreateStripeUserRequestDTO {
    /** The phone number of the user. */
    private String phoneNumber;

    /** The username of the user. */
    private String userName;
}