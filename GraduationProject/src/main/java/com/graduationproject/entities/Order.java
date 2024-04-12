package com.graduationproject.entities;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name="orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer Id;

    @Column(name = "order_name")
    private String orderName;

    @Column(name = "count_of_orders")
    private Integer countOfOrders;

    private Integer weight;
    private boolean breakable;

    @Column(name = "expiry_date")
    private String expiryDate;

    @Column(name = "expected_price")
    private double expectedPrice;

    @Column(name = "order_photo_url")
    private String orderPhotoUrl;

    @Column(name = "starting_location")
    private String from;

    @Column(name = "destination")
    private String to;

    @Column(name = "sender_name")
    private String SenderName;

    @Column(name = "receiver_phone_number")
    private String ReceiverPhoneNumber;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Enumerated(EnumType.STRING)
    private OrderStatus orderStatus;
}
