package com.graduationproject.entities;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "vodafone_payments")
public class PaymobResponse {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long externalId;
    private boolean pending;
    private Integer amountCents;
    private String currency;
}