package com.graduationproject.DTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing a search order.
 */
@Data
public class SearchOrderDTO {
    /** The ID of the order. */
    private Integer id;

    /** The name of the order. */
    private String orderName;

    /** The ID of the user who placed the order. */
    private Integer userId;

    /** The count of orders. */
    private Integer countOfOrders;

    /** The weight of the order. */
    private Integer weight;

    /** Indicates whether the order is breakable. */
    private boolean breakable;

    /** The expiry date of the order. */
    private String expiryDate;

    /** The expected price of the order. */
    private double expectedPrice;

    /** The URL of the order's photo. */
    private String orderPhotoURL;

    /** The starting location of the order. */
    private String from;

    /** The destination of the order. */
    private String to;

    /** The name of the sender. */
    private String senderName;

    /** The phone number of the receiver. */
    private String receiverPhoneNumber;
}