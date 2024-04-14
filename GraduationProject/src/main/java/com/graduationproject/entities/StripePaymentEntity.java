package com.graduationproject.entities;

import jakarta.persistence.*;
import javax.validation.constraints.NotNull;
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
    private Long amount;

    /** The timestamp of the payment. */
    private LocalDateTime timestamp;

    /** The Stripe user ID associated with the payment. */
    @NotNull
    private String stripeUserId;

    /** The user associated with the payment. */
    @ManyToOne
    @JoinColumn(name = "phone_number")
    private User user;
}