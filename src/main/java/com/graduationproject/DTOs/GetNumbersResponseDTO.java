package com.graduationproject.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GetNumbersResponseDTO {
    private Long numOfUsers;
    private Long numOfCommuters;
    private Long numOfOrders;
}
