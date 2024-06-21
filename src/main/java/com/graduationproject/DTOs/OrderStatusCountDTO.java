package com.graduationproject.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderStatusCountDTO {
    private Long numOfAllOrders;
    private Long numOfPendingOrders;
    private Long numOfConfirmedOrders;
    private Long numOfInProgressOrders;
    private Long numOfFailedOrders;
}
