package com.graduationproject.DTOs;

import lombok.Data;



@Data
public class OrderPickDTO {
    private Integer orderId;
    private Integer commuterId;
    private double apllicantPrice;
}

