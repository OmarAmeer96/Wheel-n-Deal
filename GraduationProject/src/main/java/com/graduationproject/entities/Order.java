package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;

@Data
@Entity
@Table(name="orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer Id;

    @NotNull
    @NotBlank
    @Column(name = "order_name")
    @Size(min = 3, max = 100, message = "Order name must be between 3 and 100 characters long")
    private String orderName;

    @NotNull
    @Column(name = "count_of_orders")
    @Min(value = 1, message = "Minimum value for Count Of Orders is 1")
    private Integer countOfOrders;

    @NotNull
    @Min(value = 0, message = "Minimum value for Weight is 0")
    private Integer weight;

    @NotNull
    private boolean breakable;

    @NotNull
    @NotBlank
    @Column(name = "expiry_date")
    private String expiryDate;

    @NotNull
    @Column(name = "expected_price")
    @DecimalMin(value = "0.01", message = "Expected price must be greater than 0")
    private double expectedPrice;

    @NotNull
    @NotBlank
    @Column(name = "order_photo_url")
    private String orderPhotoUrl;

    @NotNull
    @NotBlank
    @Column(name = "starting_location")
    @Size(min = 3, max = 100, message = "Starting location must be between 3 and 100 characters long")
    private String from;

    @NotNull
    @NotBlank
    @Column(name = "destination")
    @Size(min = 3, max = 100, message = "Destination must be between 3 and 100 characters long")
    private String to;

    @NotNull
    @NotBlank
    @Column(name = "sender_name")
    @Size(min = 3, max = 100, message = "Sender name must be between 3 and 100 characters long")
    private String SenderName;

    @NotNull
    @NotBlank
    @Column(name = "receiver_phone_number", length = 13)
    @Pattern(regexp = "^(\\+20)?01[0-2]{1}[0-9]{8}$", message = "Invalid Egyptian phone number")
    private String ReceiverPhoneNumber;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Enumerated(EnumType.STRING)
    private OrderStatus orderStatus;
}