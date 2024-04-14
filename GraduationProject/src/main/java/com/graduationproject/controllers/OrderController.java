package com.graduationproject.controllers;

import com.graduationproject.DTOs.OrderDTO;
import com.graduationproject.DTOs.SearchOrderDTO;
import com.graduationproject.services.impl.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller class for handling user orders.
 */
@RestController
@RequestMapping("api/v1/user")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    /**
     * Endpoint for creating or updating an order.
     * @param orderDTO DTO containing order details
     * @return ResponseEntity containing the result of the operation
     */
    @PostMapping("create-update")
    public ResponseEntity<String> createOrder(@ModelAttribute OrderDTO orderDTO) {
        return orderService.createOrUpdateOrder(orderDTO);
    }

    /**
     * Endpoint for searching orders by start and end locations.
     * @param from The starting location
     * @param to The destination location
     * @return List of SearchOrderDTOs representing the search results
     */
    @GetMapping("searchOrders/{from}/{to}")
    public List<SearchOrderDTO> searchOrder(@PathVariable String from, @PathVariable String to){
        return orderService.searchForOrder(from,to);
    }
}