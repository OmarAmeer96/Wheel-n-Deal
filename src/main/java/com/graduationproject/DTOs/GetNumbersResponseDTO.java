package com.graduationproject.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GetNumbersResponseDTO {
    private Long numOfAllUsers;
    private Long numOfCustomers;
    private Long numOfCommuters;
    private Long totalRevenue;
    private Long numOfAllOrders;
    private Long numOfNotActiveOrders;
    private Long numOfPendingOrders;
    private Long numOfConfirmedOrders;
    private Long numOfInProgressOrders;
    private Long numOfInSuccessOrders;
    private Long numOfFailedOrders;
    private Long numOfInReturnedOrders;
}
