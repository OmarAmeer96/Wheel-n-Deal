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

    public ResponseEntity<CustomResponse> createOrUpdateOrder(OrderDTO orderDTO) {
        if (orderDTO.getId() != null) {
            Optional<Order> optionalOrder = orderRepository.findById(orderDTO.getId());

            if (optionalOrder.isPresent()) {
                Order existingOrder = optionalOrder.get();
                updateOrderFromDTO(existingOrder, orderDTO);
                orderRepository.save(existingOrder);
                return ResponseEntity.ok().body(CustomResponse.builder()
                        .status(HttpStatus.OK.value())
                        .message("Order updated Successfully")
                        .build()); // Update the existing order
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(CustomResponse.builder()
                        .status(HttpStatus.NOT_FOUND.value())
                        .message("Order not found with ID: " + orderDTO.getId())
                        .build());
            }
        } else {
            ResponseEntity<CustomResponse> newOrderResponse = saveNewOrderFromDTO(orderDTO);
            CustomResponse responseBody = newOrderResponse.getBody();
            ObjectMapper objectMapper = new ObjectMapper();
            if (newOrderResponse.getStatusCode() == HttpStatus.OK && responseBody.getData() != null) {
                OrderDTO newOrderDTO = objectMapper.convertValue(responseBody.getData().get("orderDTO"), OrderDTO.class);
                return ResponseEntity.ok().body(CustomResponse.builder()
                        .status(HttpStatus.OK.value())
                        .message("Order Created Successfully")
                        .data(Map.of("orderDTO", String.valueOf(newOrderDTO)))
                        .build());
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(CustomResponse.builder()
                        .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                        .message("Failed to create order")
                        .build());
            }
        }
    }

    private ResponseEntity<CustomResponse> saveNewOrderFromDTO(OrderDTO orderDTO) {
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
    

    /**
     * Updates an Order entity based on the provided OrderDTO.
     * @param order The Order entity to be updated
     * @param orderDTO The OrderDTO containing updated order information
     */
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

    /**
     * Updates a SearchOrderDTO object based on an Order entity.
     * @param searchOrderDTO The SearchOrderDTO object to be updated
     * @param order The Order entity containing order information
     */
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

    /**
     * Searches for orders with the specified origin and destination.
     * @param from The origin of the order
     * @param to The destination of the order
     * @return List of SearchOrderDTO objects representing the search results
     */
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