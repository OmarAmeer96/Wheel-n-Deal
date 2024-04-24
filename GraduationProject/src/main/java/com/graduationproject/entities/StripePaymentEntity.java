package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "visa_payments")
public class StripePaymentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull(message = "Amount must not be null")
    @Min(value = 1, message = "Amount must be greater than 0")
    private Long amount;

    @NotNull(message = "Timestamp must not be null")
    private LocalDateTime timestamp;

    @NotBlank
    @NotNull(message = "Stripe user ID must not be null")
    @Pattern(regexp = "^cus_[a-zA-Z0-9]+$", message = "Invalid Stripe user ID format")
    private String stripeUserId;
}