package com.graduationproject.services.impl;

import com.graduationproject.DTOs.*;
import com.graduationproject.entities.OrderStatus;
import com.graduationproject.entities.Role;
import com.graduationproject.repositories.OrderRepository;
import com.graduationproject.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AdminService {
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;

    public CustomResponse findUsersByRole(Role role, Integer pageNum, Integer pageSize) {
        try {
            if (role == null) {
                return new CustomResponse(
                        HttpStatus.BAD_REQUEST.value(),
                        "Role cannot be null",
                        null);
            }

            if (pageNum < 0) {
                return new CustomResponse(
                        HttpStatus.BAD_REQUEST.value(),
                        "Invalid page number or page size",
                        null);
            }

            Pageable page = PageRequest.of(pageNum, pageSize, Sort.by("id"));
            Page<UserDTO> usersPage = userRepository.findUsersByRole(role, page);

            if (usersPage.isEmpty()) {
                return new CustomResponse(
                        HttpStatus.NO_CONTENT.value(),
                        "No users found for the given role",
                        null);
            }

            return new CustomResponse(
                    HttpStatus.OK.value(),
                    "Users found",
                    usersPage);

        } catch (Exception e) {
            return new CustomResponse(
                    HttpStatus.INTERNAL_SERVER_ERROR.value(),
                    "An error occurred: " + e.getMessage(),
                    null);
        }
    }

    public CustomResponse findAllOrders(Integer pageNum, Integer pageSize) {
        try {
            if (pageNum < 0 || pageSize <= 0) {
                return CustomResponse.builder()
                        .status(HttpStatus.BAD_REQUEST.value())
                        .message("Invalid page number or page size")
                        .data(null)
                        .build();
            }

            Pageable page = PageRequest.of(pageNum, pageSize, Sort.by("id"));
            Page<GetAllOrders> orders = orderRepository.findAllOrders(page);

            if (orders.isEmpty()) {
                return CustomResponse.builder()
                        .status(HttpStatus.NO_CONTENT.value())
                        .message("No orders found")
                        .data(null)
                        .build();
            }

            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Orders retrieved successfully")
                    .data(orders)
                    .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while retrieving orders: " + e.getMessage())
                    .data(null)
                    .build();
        }
    }

    public CustomResponse countAll() {
        try {
            Long users = userRepository.countUsersByRole(Role.valueOf("USER"));
            Long commuters = userRepository.countUsersByRole(Role.valueOf("COMMUTER"));
            Long orders = orderRepository.countAllOrders();
            Long revenue = userRepository.findSumAmount();

            if (users == null || commuters == null || orders == null) {
                return CustomResponse.builder()
                        .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                        .message("An error occurred while counting")
                        .data(null)
                        .build();
            }

            GetNumbersResponseDTO responseDTO = new GetNumbersResponseDTO(
                    users+commuters,
                    users.longValue(),
                    commuters.longValue(),
                    orders,
                    revenue
            );

            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Counts retrieved successfully")
                    .data(responseDTO)
                    .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while counting all entities: " + e.getMessage())
                    .data(null)
                    .build();
        }
    }

    public CustomResponse countOrdersByStatus() {
        try {
            OrderStatusCountDTO orderStatusCountDTO = new OrderStatusCountDTO();

            orderStatusCountDTO.setNumOfPendingOrders(orderRepository.countOrdersByStatus(OrderStatus.PENDING));
            orderStatusCountDTO.setNumOfConfirmedOrders(orderRepository.countOrdersByStatus(OrderStatus.CONFIRMED));
            orderStatusCountDTO.setNumOfInProgressOrders(orderRepository.countOrdersByStatus(OrderStatus.IN_PROGRESS));
            orderStatusCountDTO.setNumOfFailedOrders(orderRepository.countOrdersByStatus(OrderStatus.FAILED));
            orderStatusCountDTO.setNumOfAllOrders(orderRepository.countAllOrders());

            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Order status counts retrieved successfully")
                    .data(orderStatusCountDTO)
                    .build();
        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while counting orders by status: " + e.getMessage())
                    .data(null)
                    .build();
        }
    }



}
