package com.graduationproject.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GetOrdersDTO {
    private Integer id;
    private String orderName;
    private Integer countOfOrders;
    private boolean breakable;
    private String expiryDate;
    private double expectedPrice;
    private String orderPhotoUrl;
    private String from;
    private String to;
    private String senderPhoneNumber;
    private String receiverPhoneNumber;
}
