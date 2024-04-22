package com.graduationproject.DTOs.paymobPaymentDTOs;

import lombok.Data;

@Data
public class SourceData {
    private String type;
    private String phone_number;
    private String owner_name;
    private String sub_type;
    private String pan;
}