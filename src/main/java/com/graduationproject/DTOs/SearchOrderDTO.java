package com.graduationproject.DTOs;

import lombok.Data;

@Data
public class SearchOrderDTO {
    private Integer id;
    private String orderName;
    private Integer userId;
    private Integer countOfOrders;
    private Integer weight;
    private boolean breakable;
    private String expiryDate;
    private double expectedPrice;
    private String orderPhotoURL;
    private String from;
    private String to;
    private String senderName;
    private String senderPhoneNumber;
    private String receiverName;
    private String receiverPhoneNumber;
}
