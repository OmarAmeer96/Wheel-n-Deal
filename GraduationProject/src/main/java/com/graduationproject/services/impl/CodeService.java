package com.graduationproject.services.impl;

import com.graduationproject.entities.Order;
import com.graduationproject.entities.OrderStatus;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.OrderRepository;
import com.graduationproject.repositories.UserRepository;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Data
@Service
@RequiredArgsConstructor
public class CodeService {
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;

    public void generateCode(Integer orderId) {
        Optional<Order> optioanlOrder = orderRepository.findById(orderId);
        if (optioanlOrder.isPresent()) {
            Order order = optioanlOrder.get();

            UUID senderUuid = UUID.randomUUID();
            UUID receiverUuid = UUID.randomUUID();

            String senderCode = senderUuid.toString().replace("-", "");
            String receiverCode = receiverUuid.toString().replace("-", "");

            order.setSenderCode(senderCode);
            order.setReceiverCode(receiverCode);
            orderRepository.save(order);
        }
    }

    //TODO : Don't forget the payment process
    public ResponseEntity<?> checkSenderCode(Integer orderId, String enteredCode) {
        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest().body(Map.of("message", "Invalid order ID provided."));
        }
        if (enteredCode == null || enteredCode.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("message", "Entered code cannot be null or empty."));
        }

        Optional<Order> optionalOrder = orderRepository.findById(orderId);

        if (optionalOrder.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "Order not found with ID: " + orderId));
        }

        Order existingOrder = optionalOrder.get();

        if (!existingOrder.getOrderStatus().equals(OrderStatus.PENDING)) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Order is not in PENDING status."));
        }

        String senderCode = existingOrder.getSenderCode();
        if (!senderCode.equals(enteredCode)) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Incorrect sender code."));
        }

        existingOrder.setOrderStatus(OrderStatus.IN_PROGRESS);
        User commuter = existingOrder.getCommuter();
        if (commuter != null) {
            Integer commuterTotalDelivers = commuter.getTotalDelivers();
            commuter.setTotalDelivers(commuterTotalDelivers + 1);
            userRepository.save(commuter);
        }
        orderRepository.save(existingOrder);

        return ResponseEntity.ok("Sender code verified successfully. Order status updated to IN_PROGRESS.");
    }

    //TODO : here add the order money to the commuter amount
    public ResponseEntity<?> checkReceiverCode(Integer orderId, String enteredCode) {
        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest().body(Map.of("message", "Invalid order ID provided."));
        }
        if (enteredCode == null || enteredCode.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("message", "Entered code cannot be null or empty."));
        }

        Optional<Order> optionalOrder = orderRepository.findById(orderId);

        if (optionalOrder.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "Order not found with ID: " + orderId));
        }

        Order existingOrder = optionalOrder.get();

        if (!existingOrder.getOrderStatus().equals(OrderStatus.IN_PROGRESS)) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Order is not in IN_PROGRESS status."));
        }

        String receiverCode = existingOrder.getReceiverCode();
        if (!receiverCode.equals(enteredCode)) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Incorrect receiver code."));
        }

        existingOrder.setOrderStatus(OrderStatus.SUCCESS);
        orderRepository.save(existingOrder);

        return ResponseEntity.ok("Receiver code verified successfully. Order status updated to SUCCESS.");
    }

    public ResponseEntity<?> checkFailureCode(Integer orderId, String enteredCode) {
        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Invalid order ID provided."));
        }
        if (enteredCode == null || enteredCode.trim().isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Failure code cannot be null or empty."));
        }

        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "Order not found with ID: " + orderId));
        }

        Order existingOrder = optionalOrder.get();

        if (!existingOrder.getOrderStatus().equals(OrderStatus.FAILED)) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Order is not in FAILED status."));
        }

        String failureCode = existingOrder.getSenderCode();
        if (!failureCode.equals(enteredCode)) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Incorrect failure code."));
        }

        existingOrder.setOrderStatus(OrderStatus.RETURNED);
        orderRepository.save(existingOrder);

        return ResponseEntity.ok().build();
    }

    public ResponseEntity<?> getSenderCode(Integer orderId) {
        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Invalid order ID provided."));
        }

        Optional<Order> optionalOrder = orderRepository.findById(orderId);

        if (optionalOrder.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "Order not found with ID: " + orderId));
        }

        String senderCode = optionalOrder.get().getSenderCode();

        return ResponseEntity.ok(Map.of("senderCode", senderCode));
    }

    public ResponseEntity<?> getReceiverCode(Integer orderId) {
        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Invalid order ID provided."));
        }

        Optional<Order> optionalOrder = orderRepository.findById(orderId);

        if (optionalOrder.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "Order not found with ID: " + orderId));
        }

        String receiverCode = optionalOrder.get().getReceiverCode();

        return ResponseEntity.ok(Map.of("receiverCode", receiverCode));
    }

}