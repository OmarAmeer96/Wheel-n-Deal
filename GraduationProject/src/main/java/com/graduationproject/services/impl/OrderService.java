package com.graduationproject.services.impl;

import com.graduationproject.DTOs.OrderDTO;
import com.graduationproject.entities.Order;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.OrderRepository;
import com.graduationproject.repositories.UserRepository;
import com.graduationproject.utils.Utils;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Data
@RequiredArgsConstructor
@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;

    public ResponseEntity<String> createOrUpdateOrder(OrderDTO orderDTO) {
        if (orderDTO.getId() != null) {
            Optional<Order> optionalOrder = orderRepository.findById(orderDTO.getId());

            if (optionalOrder.isPresent()) {
                Order existingOrder = optionalOrder.get();
                updateOrderFromDTO(existingOrder, orderDTO);
                orderRepository.save(existingOrder);
                return ResponseEntity.ok("Order updated Successfully");// Update the existing order
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Order not found with ID: " + orderDTO.getId());
            }
        } else {
            saveNewOrderFromDTO(orderDTO);
            return ResponseEntity.ok("Order Created Successfully");
        }
    }

    private Order saveNewOrderFromDTO(OrderDTO orderDTO) {
        Optional<User> optionalUser = userRepository.findById(orderDTO.getUserId());
        if (optionalUser.isEmpty()) {
            throw new RuntimeException("User not found with ID: " + orderDTO.getUserId());
        }

        Order order = new Order();
        updateOrderFromDTO(order, orderDTO);

        User user = optionalUser.get();
        order.setUser(user);

        return orderRepository.save(order);
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

}
