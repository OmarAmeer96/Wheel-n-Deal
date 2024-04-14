package com.graduationproject.entities;

import jakarta.persistence.*;
import lombok.Data;

/**
 * Represents an order entity in the application.
 */
@Data
@Entity
@Table(name="orders")
public class Order {
    /** The unique identifier for the order. */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer Id;

    /** The name of the order. */
    @Column(name = "order_name")
    private String orderName;

    /** The count of orders. */
    @Column(name = "count_of_orders")
    private Integer countOfOrders;

    /** The weight of the order. */
    private Integer weight;

    /** Indicates whether the order is breakable. */
    private boolean breakable;

    /** The expiry date of the order. */
    @Column(name = "expiry_date")
    private String expiryDate;

    /** The expected price of the order. */
    @Column(name = "expected_price")
    private double expectedPrice;

    /** The URL of the photo associated with the order. */
    @Column(name = "order_photo_url")
    private String orderPhotoUrl;

    /** The starting location of the order. */
    @Column(name = "starting_location")
    private String from;

    /** The destination of the order. */
    @Column(name = "destination")
    private String to;

    /** The name of the sender. */
    @Column(name = "sender_name")
    private String SenderName;

    /** The phone number of the receiver. */
    @Column(name = "receiver_phone_number")
    private String ReceiverPhoneNumber;

    /** The user who placed the order. */
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    /** The status of the order. */
    @Enumerated(EnumType.STRING)
    private OrderStatus orderStatus;
}