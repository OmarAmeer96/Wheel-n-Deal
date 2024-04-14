package com.graduationproject.entities;

import jakarta.persistence.*;
import lombok.Data;

/**
 * Represents a Paymob response entity in the application.
 */
@Data
@Entity
@Table(name = "vodafone_payments")
public class PaymobResponse {
    /** The unique identifier for the Paymob response. */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** The external ID associated with the Paymob response. */
    private Long externalId;

    /** Indicates whether the payment is pending. */
    private boolean pending;

    /** The amount in cents for the payment. */
    private int amountCents;

    /** The currency of the payment. */
    private String currency;
}