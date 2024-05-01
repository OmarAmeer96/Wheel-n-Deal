package com.graduationproject.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.testcontainers.shaded.org.checkerframework.common.aliasing.qual.Unique;

@Data
@Entity
@Table(name="promo_code")
public class PromoCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Unique
    @NotNull
    private String promoCode;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @JsonBackReference
    private User user;

    @Column(name = "discount_Amount")
    @NotNull
    private double discountAmount;

    @Enumerated(EnumType.STRING)
    @NotNull
    private PromocodeStatus promocodeStatus;
}
