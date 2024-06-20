package com.graduationproject.DTOs;

import com.graduationproject.entities.OrderStatus;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GetAllOrders {
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
    private String commuterPhoneNumber;
    private OrderStatus orderStatus;
}
