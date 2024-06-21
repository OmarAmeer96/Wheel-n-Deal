package com.graduationproject.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GetNumbersResponseDTO {
    private Long numOfAllUsers;
    private Long numOfCustomers;
    private Long numOfCommuters;
    private Long numOfOrders;
    private Long totalRevenue;
}
