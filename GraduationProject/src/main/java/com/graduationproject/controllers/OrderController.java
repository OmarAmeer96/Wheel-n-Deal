package com.graduationproject.controllers;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.OrderDTO;
import com.graduationproject.DTOs.SearchOrderDTO;
import com.graduationproject.services.impl.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/user")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    @PostMapping("create-update")
    public CustomResponse createOrder(@ModelAttribute OrderDTO orderDTO) {
        return orderService.createOrUpdateOrder(orderDTO);
    }

    @GetMapping("searchOrders/{from}/{to}")
    public CustomResponse searchOrder(@PathVariable String from, @PathVariable String to){
        return orderService.searchForOrder(from,to);
    }
}