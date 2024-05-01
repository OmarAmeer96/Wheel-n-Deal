package com.graduationproject.entities;


import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.List;

@Data
@Entity
@Table(name = "order_applicants")
public class OrderApplicants {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer Id;

    @ManyToOne
    @JoinColumn(name = "order_id")
    @NotNull
    private Order order;

    @ManyToOne
    @JoinColumn(name = "commuter_id")
    @NotNull
    @JsonBackReference
    private User commuter;

    @Column(name = "apllicant_price")
    @NotNull
    private double apllicantPrice;
}
