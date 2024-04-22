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
import com.fasterxml.jackson.databind.ObjectMapper;

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
    public ResponseEntity<CustomResponse> createOrUpdateOrder(OrderDTO orderDTO) {
        if (orderDTO.getId() != null) {
            Optional<Order> optionalOrder = orderRepository.findById(orderDTO.getId());

            if (optionalOrder.isPresent()) {
                Order existingOrder = optionalOrder.get();
                updateOrderFromDTO(existingOrder, orderDTO);
                orderRepository.save(existingOrder);
                return ResponseEntity.ok().body(CustomResponse.builder().status(HttpStatus.OK.value()).message("Order updated Successfully").build()); // Update the existing order
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(CustomResponse.builder().status(HttpStatus.NOT_FOUND.value()).message("Order not found with ID: " + orderDTO.getId()).build());
            }
        } else {
            ResponseEntity<CustomResponse> newOrder = saveNewOrderFromDTO(orderDTO);
            if (newOrder != null) {
                return ResponseEntity.ok().body(CustomResponse.builder().status(HttpStatus.OK.value()).message("Order Created Successfully").data(Map.of("orderId", newOrder.getBody().toString())).build());
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(CustomResponse.builder().status(HttpStatus.INTERNAL_SERVER_ERROR.value()).message("Failed to create order").build());
            }
        }
    }

    @Transactional
    protected ResponseEntity<CustomResponse> saveNewOrderFromDTO(OrderDTO orderDTO) {
        Optional<User> optionalUser = userRepository.findById(orderDTO.getUserId());
        if (optionalUser.isPresent()) {
            Order order = new Order();
            updateOrderFromDTO(order, orderDTO);

            User user = optionalUser.get();
            order.setUser(user);
            order.setOrderStatus(OrderStatus.NOT_ACTIVE);

            Order savedOrder = orderRepository.save(order);

            return ResponseEntity.ok().body(CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Order Created Successfully")
                    .data(Map.of("orderId", savedOrder.getId().toString()))
                    .build());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(CustomResponse.builder()
                    .status(HttpStatus.NOT_FOUND.value())
                    .message("User not found with ID: " + orderDTO.getUserId())
                    .build());
        }
    }

    private void updateOrderFromDTO(Order order, OrderDTO orderDTO) {
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
    }

    private void updateSearchOrderDTOFromOrder(SearchOrderDTO searchOrderDTO, Order order){
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
    }

    public List<SearchOrderDTO> searchForOrder(String from, String to){
        List<SearchOrderDTO> searchOrderDTOS = new ArrayList<>();
        List<Order> existingOrders = orderRepository.findByFromAndTo(from,to);
        for(Order order : existingOrders){
            SearchOrderDTO searchOrderDTO = new SearchOrderDTO();
            updateSearchOrderDTOFromOrder(searchOrderDTO,order);
            searchOrderDTOS.add(searchOrderDTO);
        }
        return searchOrderDTOS;
    }
}