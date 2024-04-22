package com.graduationproject.DTOs.paymobPaymentDTOs;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class PayResponseDTO {
    private Long id;
    private boolean pending;
    private Long amount_cents;
    private String currency;
    private SourceData source_data;
}