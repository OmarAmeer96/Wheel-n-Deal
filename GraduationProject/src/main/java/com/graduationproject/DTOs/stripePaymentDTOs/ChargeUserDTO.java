package com.graduationproject.DTOs.stripePaymentDTOs;

import lombok.Data;
import java.util.Date;

/**
 * Data Transfer Object (DTO) representing the details for charging a user via Stripe.
 */
@Data
public class ChargeUserDTO {
    /** The username of the user. */
    private String userName;

    /** The bank name associated with the payment. */
    private String bankName;

    /** The Stripe user ID. */
    private String stripeUserId;

    /** The amount to charge the user. */
    private Long amount;

    /** The card number for the payment. */
    private String cardNumber;

    /** The expiry month of the card. */
    private String expiryMonth;

    /** The expiry year of the card. */
    private String expiryYear;

    /** The CVC (Card Verification Code) of the card. */
    private String cVC;

    /** Indicates whether the card details are saved. */
    private boolean saved;
}