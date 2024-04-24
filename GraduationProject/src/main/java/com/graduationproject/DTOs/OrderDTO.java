package com.graduationproject.DTOs;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class OrderDTO {
    private Integer id;
    private String orderName;
    private Integer userId;
    private Integer countOfOrders;
    private Integer weight;
    private boolean breakable;
    private String expiryDate;
    private double expectedPrice;
    private MultipartFile orderPhoto;
    private String from;
    private String to;
    private String senderName;
    private String senderPhoneNumber;
    private String receiverName;
    private String receiverPhoneNumber;

    //TODO : deal with dates and the price with the length of the way
}
