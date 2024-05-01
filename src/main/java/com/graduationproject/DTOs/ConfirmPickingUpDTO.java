package com.graduationproject.DTOs;

import com.graduationproject.entities.PaymentMethod;
import lombok.Data;

@Data
public class ConfirmPickingUpDTO {
    private String promoCode;
    private PaymentMethod paymentMethod;
    private Integer commuterId;
    //I will get the UserId from the orderId
    private Integer orderId;
    private double price;
}
