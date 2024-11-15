package com.graduationproject.DTOs;

import lombok.Data;

@Data
public class SearchOrderDTO {
    private Integer id;
    private String orderName;
    private Integer userId;
    private Integer countOfOrders;
    private Integer weight;
    private Boolean breakable;
    private String expiryDate;
    private Double expectedPrice;
    private String orderPhotoURL;
    private String from;
    private String to;
    private String senderName;
    private String senderPhoneNumber;
    private String receiverName;
    private String receiverPhoneNumber;
}
