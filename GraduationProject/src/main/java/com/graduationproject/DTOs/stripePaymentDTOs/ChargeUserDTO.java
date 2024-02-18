package com.graduationproject.DTOs.stripePaymentDTOs;

import lombok.Data;
import java.util.Date;

@Data
public class ChargeUserDTO {
    private String userName;
    private String bankName;
    private String stripeUserId;
    private Long amount;
    private String cardNumber;
    private Date expiryDate;
    private String cVC;
    private boolean saved;
}
