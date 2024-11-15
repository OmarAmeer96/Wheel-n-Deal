package com.graduationproject.DTOs;

import com.graduationproject.entities.OrderStatus;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GetOrdersDTO {
    private Integer Id;
    private String orderName;
    private Integer countOfOrders;
    private Boolean breakable;
    private String expiryDate;
    private Double expectedPrice;
    private String orderPhotoUrl;
    private String from;
    private String to;
    private String SenderPhoneNumber;
    private String ReceiverPhoneNumber;
    private OrderStatus orderStatus;
}
