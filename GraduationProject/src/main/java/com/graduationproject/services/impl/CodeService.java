package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.entities.Order;
import com.graduationproject.entities.OrderStatus;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.OrderRepository;
import com.graduationproject.repositories.UserRepository;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Data
@RequiredArgsConstructor
@Service
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
    public CustomResponse checkSenderCode(Integer orderId, String enteredCode) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order existingOrder = optionalOrder.get();
            OrderStatus orderStatus = existingOrder.getOrderStatus();
            if (orderStatus.equals(OrderStatus.PENDING)) {
                String senderCode = existingOrder.getSenderCode();
                if (senderCode.equals(enteredCode)) {
                    existingOrder.setOrderStatus(OrderStatus.IN_PROGRESS);
                    User commuter = existingOrder.getCommuter();
                    Integer commuterTotalDelivers = commuter.getTotalDelivers();
                    commuterTotalDelivers += 1;
                    commuter.setTotalDelivers(commuterTotalDelivers);
                    userRepository.save(commuter);
                    orderRepository.save(existingOrder);
                    return CustomResponse.builder()
                            .status(HttpStatus.OK.value())
                            .message("Sender code verified successfully. Order status updated to IN_PROGRESS.")
                            .build();
                } else {
                    return CustomResponse.builder()
                            .status(HttpStatus.BAD_REQUEST.value())
                            .message("Incorrect sender code.")
                            .build();
                }
            } else {
                return CustomResponse.builder()
                        .status(HttpStatus.BAD_REQUEST.value())
                        .message("Order is not in PENDING status.")
                        .build();
            }
        } else {
            return CustomResponse.builder()
                    .status(HttpStatus.NOT_FOUND.value())
                    .message("Order not found with ID: " + orderId)
                    .build();
        }
    }


    //TODO : here add the order money to the commuter amount
    public CustomResponse checkReceiverCode(Integer orderId, String enteredCode) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order existingOrder = optionalOrder.get();
            OrderStatus orderStatus = existingOrder.getOrderStatus();
            if (orderStatus.equals(OrderStatus.IN_PROGRESS)) {
                String receiverCode = existingOrder.getReceiverCode();
                if (receiverCode.equals(enteredCode)) {
                    existingOrder.setOrderStatus(OrderStatus.SUCCESS);
                    orderRepository.save(existingOrder);
                    return CustomResponse.builder()
                            .status(HttpStatus.OK.value())
                            .message("Receiver code verified successfully. Order status updated to SUCCESS.")
                            .build();
                } else {
                    return CustomResponse.builder()
                            .status(HttpStatus.BAD_REQUEST.value())
                            .message("Incorrect receiver code.")
                            .build();
                }
            } else {
                return CustomResponse.builder()
                        .status(HttpStatus.BAD_REQUEST.value())
                        .message("Order is not in IN_PROGRESS status.")
                        .build();
            }
        } else {
            return CustomResponse.builder()
                    .status(HttpStatus.NOT_FOUND.value())
                    .message("Order not found with ID: " + orderId)
                    .build();
        }
    }

    public CustomResponse checkFailureCode(Integer orderId, String enteredCode) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order existingOrder = optionalOrder.get();
            OrderStatus orderStatus = existingOrder.getOrderStatus();
            if (orderStatus.equals(OrderStatus.FAILED)) {
                String failureCode = existingOrder.getSenderCode();
                if (failureCode.equals(enteredCode)) {
                    existingOrder.setOrderStatus(OrderStatus.RETURNED);
                    orderRepository.save(existingOrder);
                    return CustomResponse.builder()
                            .status(HttpStatus.OK.value())
                            .message("Failure code verified successfully. Order status updated to RETURNED.")
                            .build();
                } else {
                    return CustomResponse.builder()
                            .status(HttpStatus.BAD_REQUEST.value())
                            .message("Incorrect failure code.")
                            .build();
                }
            } else {
                return CustomResponse.builder()
                        .status(HttpStatus.BAD_REQUEST.value())
                        .message("Order is not in FAILED status.")
                        .build();
            }
        } else {
            return CustomResponse.builder()
                    .status(HttpStatus.NOT_FOUND.value())
                    .message("Order not found with ID: " + orderId)
                    .build();
        }
    }


    public CustomResponse getSenderCode(Integer orderId) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            String senderCode = optionalOrder.get().getSenderCode();
            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Sender code retrieved successfully.")
                    .data(senderCode)
                    .build();
        } else {
            return CustomResponse.builder()
                    .status(HttpStatus.NOT_FOUND.value())
                    .message("Order not found with ID: " + orderId)
                    .build();
        }
    }


    public CustomResponse getReceiverCode(Integer orderId) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            String receiverCode = optionalOrder.get().getReceiverCode();
            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Receiver code retrieved successfully.")
                    .data(receiverCode)
                    .build();
        } else {
            return CustomResponse.builder()
                    .status(HttpStatus.NOT_FOUND.value())
                    .message("Order not found with ID: " + orderId)
                    .build();
        }
    }


}