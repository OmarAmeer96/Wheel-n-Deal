package com.graduationproject.entities;

import jakarta.persistence.*;
import javax.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "visa_payments")
public class StripePaymentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long amount;
    private LocalDateTime timestamp;
    @NotNull
    private String stripeUserId;
    @ManyToOne
    @JoinColumn(name = "phone_number")
    private User user;
}
