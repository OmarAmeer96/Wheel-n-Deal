package com.graduationproject.services.impl;

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

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Service class responsible for managing orders.
 */
@Data
@Service
@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;

    /**
     * Creates or updates an order based on the provided OrderDTO.
     * @param orderDTO The OrderDTO containing order information
     * @return ResponseEntity with a message indicating the success or failure of the operation
     */
    public ResponseEntity<String> createOrUpdateOrder(OrderDTO orderDTO) {
        if (orderDTO.getId() != null) {
            Optional<Order> optionalOrder = orderRepository.findById(orderDTO.getId());

            if (optionalOrder.isPresent()) {
                Order existingOrder = optionalOrder.get();
                updateOrderFromDTO(existingOrder, orderDTO);
                orderRepository.save(existingOrder);
                return ResponseEntity.ok("Order updated Successfully"); // Update the existing order
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Order not found with ID: " + orderDTO.getId());
            }
        } else {
            saveNewOrderFromDTO(orderDTO);
            return ResponseEntity.ok("Order Created Successfully");
        }
    }

    /**
     * Saves a new order based on the provided OrderDTO.
     * @param orderDTO The OrderDTO containing order information
     * @return The newly created Order
     */
    private Order saveNewOrderFromDTO(OrderDTO orderDTO) {
        Optional<User> optionalUser = userRepository.findById(orderDTO.getUserId());
        if (optionalUser.isEmpty()) {
            throw new RuntimeException("User not found with ID: " + orderDTO.getUserId());
        }

        Order order = new Order();
        updateOrderFromDTO(order, orderDTO);

        User user = optionalUser.get();
        order.setUser(user);
        order.setOrderStatus(OrderStatus.NOT_ACTIVE);

        return orderRepository.save(order);
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