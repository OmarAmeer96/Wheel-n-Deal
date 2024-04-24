package com.graduationproject.DTOs;

import com.graduationproject.entities.PromoCode;
import lombok.Data;

@Data
public class NegotiationAcceptDTO {
    private Integer commuterId;
    private Integer orderId;
    private PromoCode promoCode;
}
