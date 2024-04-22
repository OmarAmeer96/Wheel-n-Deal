package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.OrderDTO;
import com.graduationproject.DTOs.SearchOrderDTO;
import com.graduationproject.entities.Order;
import com.graduationproject.entities.OrderStatus;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.OrderRepository;
import com.graduationproject.repositories.UserRepository;
import com.graduationproject.utils.Utils;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Data
@Service
@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;

    @Transactional
    public CustomResponse createOrUpdateOrder(OrderDTO orderDTO) {
        if (orderDTO.getId() != null) {
            Optional<Order> optionalOrder = orderRepository.findById(orderDTO.getId());

            if (optionalOrder.isPresent()) {
                Order existingOrder = optionalOrder.get();
                updateOrderFromDTO(existingOrder, orderDTO);
                orderRepository.save(existingOrder);
                return CustomResponse.builder().status(HttpStatus.OK.value()).message("Order updated Successfully").build(); // Update the existing order
            } else {
                return CustomResponse.builder().status(HttpStatus.NOT_FOUND.value()).message("Order not found with ID: " + orderDTO.getId()).build();
            }
        } else {
            CustomResponse newOrder = saveNewOrderFromDTO(orderDTO);
            if (newOrder != null) {
                return CustomResponse.builder().status(HttpStatus.OK.value()).message("Order Created Successfully").data(Map.of("orderId", newOrder.getData().toString())).build();
            } else {
                return CustomResponse.builder().status(HttpStatus.INTERNAL_SERVER_ERROR.value()).message("Failed to create order").build();
            }
        }
    }

    @Transactional
    protected CustomResponse saveNewOrderFromDTO(OrderDTO orderDTO) {
        Optional<User> optionalUser = userRepository.findById(orderDTO.getUserId());
        if (optionalUser.isPresent()) {
            Order order = new Order();
            updateOrderFromDTO(order, orderDTO);

            User user = optionalUser.get();
            order.setUser(user);
            order.setOrderStatus(OrderStatus.NOT_ACTIVE);

            Order savedOrder = orderRepository.save(order);

            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Order Created Successfully")
                    .data(Map.of("orderId", savedOrder.getId().toString()))
                    .build();
        } else {
            return CustomResponse.builder()
                    .status(HttpStatus.NOT_FOUND.value())
                    .message("User not found with ID: " + orderDTO.getUserId())
                    .build();
        }
    }

    public CustomResponse updateOrderFromDTO(Order order, OrderDTO orderDTO) {
        if (order == null) {
            return CustomResponse.builder()
                    .status(404) // HTTP Not Found
                    .message("Order not found.")
                    .build();
        }

        try {
            if (orderDTO == null) {
                return CustomResponse.builder()
                        .status(400) // HTTP Bad Request
                        .message("OrderDTO is null.")
                        .build();
            }

            // Validate required fields
            if (orderDTO.getOrderName() == null || orderDTO.getFrom() == null || orderDTO.getTo() == null) {
                return CustomResponse.builder()
                        .status(400) // HTTP Bad Request
                        .message("Missing required fields in OrderDTO.")
                        .build();
            }

            // Update the order with values from the DTO
            order.setOrderName(orderDTO.getOrderName());
            order.setCountOfOrders(orderDTO.getCountOfOrders());
            order.setWeight(orderDTO.getWeight());
            order.setBreakable(orderDTO.isBreakable());
            order.setExpiryDate(orderDTO.getExpiryDate());
            order.setExpectedPrice(orderDTO.getExpectedPrice());
            order.setOrderPhotoUrl(Utils.storePhotoAndGetUrl(orderDTO.getOrderPhoto()));
            order.setFrom(orderDTO.getFrom());
            order.setTo(orderDTO.getTo());
            order.setSenderName(orderDTO.getSenderName());
            order.setReceiverPhoneNumber(orderDTO.getReceiverPhoneNumber());

            // Return a success response
            return CustomResponse.builder()
                    .status(200) // HTTP OK
                    .message("Order updated successfully.")
                    .data(order) // Include updated order as data
                    .build();

        } catch (Exception e) {
            // Return an exception response
            return CustomResponse.builder()
                    .status(500) // HTTP Internal Server Error
                    .message("An error occurred while updating the order.")
                    .data(e.getMessage()) // Optional: Include exception message for debugging
                    .build();
        }
    }

    public CustomResponse updateSearchOrderDTOFromOrder(SearchOrderDTO searchOrderDTO, Order order) {
        if (searchOrderDTO == null || order == null) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("SearchOrderDTO or Order is null.")
                    .build();
        }

        try {
            // Ensure the Order has required fields populated
            if (order.getUser() == null || order.getUser().getId() == null) {
                return CustomResponse.builder()
                        .status(422)  // HTTP Unprocessable Entity
                        .message("User information is missing in Order.")
                        .build();
            }

            // Update the SearchOrderDTO from Order
            searchOrderDTO.setId(order.getId());
            searchOrderDTO.setOrderName(order.getOrderName());
            searchOrderDTO.setUserId(order.getUser().getId());
            searchOrderDTO.setCountOfOrders(order.getCountOfOrders());
            searchOrderDTO.setWeight(order.getWeight());
            searchOrderDTO.setBreakable(order.isBreakable());
            searchOrderDTO.setExpiryDate(order.getExpiryDate());
            searchOrderDTO.setExpectedPrice(order.getExpectedPrice());
            searchOrderDTO.setOrderPhotoURL(order.getOrderPhotoUrl());
            searchOrderDTO.setFrom(order.getFrom());
            searchOrderDTO.setTo(order.getTo());
            searchOrderDTO.setSenderName(order.getSenderName());
            searchOrderDTO.setReceiverPhoneNumber(order.getReceiverPhoneNumber());

            return CustomResponse.builder()
                    .status(200)  // HTTP OK
                    .message("SearchOrderDTO updated successfully.")
                    .data(searchOrderDTO)  // Return the updated DTO
                    .build();

        } catch (Exception ex) {
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("An error occurred while updating SearchOrderDTO.")
                    .data(ex.getMessage())  // Include the exception message for debugging
                    .build();
        }
    }

    public CustomResponse searchForOrder(String from, String to) {
        if (from == null || to == null) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("Origin and destination must not be null.")
                    .build();
        }

        try {
            List<SearchOrderDTO> searchOrderDTOS = new ArrayList<>();
            List<Order> existingOrders = orderRepository.findByFromAndTo(from, to);

            if (existingOrders == null || existingOrders.isEmpty()) {
                return CustomResponse.builder()
                        .status(404)  // HTTP Not Found
                        .message("No orders found between " + from + " and " + to + ".")
                        .build();
            }

            for (Order order : existingOrders) {
                SearchOrderDTO searchOrderDTO = new SearchOrderDTO();
                CustomResponse response = updateSearchOrderDTOFromOrder(searchOrderDTO, order);

                if (response.getStatus() == 200) {
                    searchOrderDTOS.add((SearchOrderDTO) response.getData());
                } else {
                    return response;  // Propagate the error from update method
                }
            }

            return CustomResponse.builder()
                    .status(200)  // HTTP OK
                    .message("Search results successfully retrieved.")
                    .data(searchOrderDTOS)  // Return the list of SearchOrderDTOs
                    .build();

        } catch (Exception ex) {
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("An error occurred during the search.")
                    .data(ex.getMessage())  // Include exception message for debugging
                    .build();
        }
    }

}