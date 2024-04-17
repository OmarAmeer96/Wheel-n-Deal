package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * Represents a Stripe payment entity in the application.
 */
@Data
@Entity
@Table(name = "visa_payments")
public class StripePaymentEntity {
    /** The unique identifier for the Stripe payment. */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** The amount of the payment. */
    @NotNull(message = "Amount must not be null")
    @Min(value = 1, message = "Amount must be greater than 0")
    private Long amount;

    /** The timestamp of the payment. */
    @NotNull(message = "Timestamp must not be null")
    private LocalDateTime timestamp;

    /** The Stripe user ID associated with the payment. */
    @NotNull(message = "Stripe user ID must not be null")
    @Pattern(regexp = "^cus_[a-zA-Z0-9]+$", message = "Invalid Stripe user ID format")
    private String stripeUserId;
}