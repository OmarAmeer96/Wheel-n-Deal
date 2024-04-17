package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
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
    @NotNull
    @Column(name = "order_name")
    @Size(min = 3, max = 100, message = "Order name must be between 3 and 100 characters long")
    private String orderName;

    /** The count of orders. */
    @NotNull
    @Column(name = "count_of_orders")
    @Min(value = 1, message = "Minimum value for Count Of Orders is 1")
    private Integer countOfOrders;

    /** The weight of the order. */
    @NotNull
    @Min(value = 0, message = "Minimum value for Weight is 0")
    private Integer weight;

    /** Indicates whether the order is breakable. */
    @NotNull
    private boolean breakable;

    /** The expiry date of the order. */
    @NotNull
    @Column(name = "expiry_date")
    private String expiryDate;

    /** The expected price of the order. */
    @NotNull
    @Column(name = "expected_price")
    @DecimalMin(value = "0.01", message = "Expected price must be greater than 0")
    private double expectedPrice;

    /** The URL of the photo associated with the order. */
    @NotNull
    @Column(name = "order_photo_url")
    private String orderPhotoUrl;

    /** The starting location of the order. */
    @NotNull
    @Column(name = "starting_location")
    @Size(min = 3, max = 100, message = "Starting location must be between 3 and 100 characters long")
    private String from;

    /** The destination of the order. */
    @NotNull
    @Column(name = "destination")
    @Size(min = 3, max = 100, message = "Destination must be between 3 and 100 characters long")
    private String to;

    /** The name of the sender. */
    @NotNull
    @Column(name = "sender_name")
    @Size(min = 3, max = 100, message = "Sender name must be between 3 and 100 characters long")
    private String SenderName;

    /** The phone number of the receiver. */
    @NotNull
    @Column(name = "receiver_phone_number", length = 13)
    @Pattern(regexp = "^(\\+20)?01[0-2]{1}[0-9]{8}$", message = "Invalid Egyptian phone number")
    private String ReceiverPhoneNumber;

    /** The user who placed the order. */
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    /** The status of the order. */
    @Enumerated(EnumType.STRING)
    private OrderStatus orderStatus;
}