package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.GetAllOrders;
import com.graduationproject.DTOs.GetOrdersDTO;
import com.graduationproject.DTOs.UserDTO;
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

    public CustomResponse countUsersByRole(Role role) {
        try {
            if (role == null) {
                return new CustomResponse(
                        HttpStatus.BAD_REQUEST.value(),
                        "Role cannot be null",
                        null);
            }
            long count = userRepository.countUsersByRole(role);

            CustomResponse response = CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("User count retrieved successfully")
                    .data(count)
                    .build();

            return response;

        } catch (Exception e) {
            CustomResponse errorResponse = CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while counting users by role: " + e.getMessage())
                    .data(null)
                    .build();

            return errorResponse;
        }
    }

    public CustomResponse findOrdersByOrderStatus(OrderStatus orderStatus, Integer pageNum, Integer pageSize) {
        try {
            if (orderStatus == null) {
                return new CustomResponse(
                        HttpStatus.BAD_REQUEST.value(),
                        "Order status cannot be null",
                        null);
            }

            if (pageNum < 0 || pageSize <= 0) {
                return new CustomResponse(
                        HttpStatus.BAD_REQUEST.value(),
                        "Invalid page number or page size",
                        null);
            }

            Pageable page = PageRequest.of(pageNum, pageSize, Sort.by("id"));
            Page<GetOrdersDTO> orders = orderRepository.findOrdersByOrderStatus(orderStatus, page);

            if (orders.isEmpty()) {
                return new CustomResponse(
                        HttpStatus.NO_CONTENT.value(),
                        "No orders found for the given status",
                        null);
            }

            CustomResponse successResponse = CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Orders retrieved successfully")
                    .data(orders)
                    .build();

            return successResponse;

        } catch (Exception e) {
            CustomResponse errorResponse = CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while retrieving orders: " + e.getMessage())
                    .data(null)
                    .build();

            return errorResponse;
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

    public CustomResponse countOrdersByStatus(OrderStatus orderStatus) {
        try {
            if (orderStatus == null) {
                return CustomResponse.builder()
                        .status(HttpStatus.BAD_REQUEST.value())
                        .message("Order status cannot be null")
                        .data(null)
                        .build();
            }

            long orderCount = orderRepository.countOrdersByStatus(orderStatus);

            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Order count retrieved successfully")
                    .data(orderCount)
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
