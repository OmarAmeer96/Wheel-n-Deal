package com.graduationproject.entities;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "vodafone_payments")
public class PaymobResponse {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long externalId;
    private boolean pending;
    private int amountCents;
    private String currency;
}

