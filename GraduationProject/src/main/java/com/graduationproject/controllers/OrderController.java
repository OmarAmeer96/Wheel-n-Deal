package com.graduationproject.controllers;

import com.graduationproject.DTOs.*;
import com.graduationproject.services.impl.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/user")
public class OrderController {

    private final OrderService orderService;

    @PostMapping("create-update")
    public ResponseEntity<Object> createOrder(@ModelAttribute OrderDTO orderDTO) {
        return orderService.createOrUpdateOrder(orderDTO);
    }

    @GetMapping("searchOrders/{from}/{to}")
    public ResponseEntity<Object> searchOrder(@PathVariable String from, @PathVariable String to){
        return orderService.searchForOrder(from,to);
    }

    @GetMapping("findAll/{userId}")
    public ResponseEntity<?> findAllByUserId(@PathVariable Integer userId){
        return orderService.findAllByUserId(userId);
    }

    @GetMapping("find-not-active/{userId}")
    public ResponseEntity<Object> findNotActiveOrders(@PathVariable Integer userId){
        return orderService.findNotActiveOrders(userId);
    }

    //here I assigne order to the commuter but make the order not active yet
    //when The commuter Accept it becomes active(pending) and the commuter moves to take it
    @PostMapping("/assign-existing-order/{orderId}/{tripId}")
    public ResponseEntity<?> assignExistingOrder(@PathVariable Integer orderId,@PathVariable Integer tripId){
        return orderService.assignExistingOrder(orderId,tripId);
    }

    //here I create order and assigned it to the commuter but make the order not active yet
    //when The commuter Accept it becomes active(pending) and the commuter moves to take it
    @PostMapping("create-and-assign/{tripId}")
    public ResponseEntity<Object> createOrderAndAssignIt(@ModelAttribute OrderDTO orderDTO,@PathVariable Integer tripId){
        return orderService.createOrderAndAssignIt(orderDTO,tripId);
    }

    @PostMapping("cancel-order/{orderId}/{canclerId}")
    public ResponseEntity<?> cancelOrder(@PathVariable Integer orderId,@PathVariable Integer canclerId){
        return orderService.cancelOrder(orderId,canclerId);
    }

    //TODO : handle the security stuff to make this endpoint only allowed for commuter
    // (must use commuter token and make sure that the id in the token is the same one that the will be passed)
    @PostMapping("findCommuterOrders/{commuterId}")
    public ResponseEntity<?> findCommuterOrders(@PathVariable Integer commuterId){
        return orderService.findCommuterOrders(commuterId);
    }

    @PostMapping("negotiate")
    public ResponseEntity<?> negotiate(@RequestBody NegotiationDTO negotiationDTO){
        return orderService.negotiate(negotiationDTO);
    }

    @PostMapping("pickOrder")
    public ResponseEntity<?> pickOrder(@RequestBody OrderPickDTO orderPickDTO){
        return orderService.pickOrder(orderPickDTO);
    }

    @GetMapping("getOrderApplicants/{orderId}")
    public ResponseEntity<?> getOrderApplicants(@PathVariable Integer orderId) {
        return orderService.getOrderApplicants(orderId);
    }

    @PostMapping("confirmPickingUp")
    public ResponseEntity<?> confirmPickingUp(@RequestBody ConfirmPickingUpDTO confirmPickingUpDTO){
        return orderService.confirmPickingUp(confirmPickingUpDTO);
    }

    @GetMapping("findOrderById/{orderId}")
    public ResponseEntity<?> findorderById(@PathVariable Integer orderId){
        return orderService.findById(orderId);
    }

    @PostMapping("declineOrder/{orderId}")
    public ResponseEntity<?> declineOrder(@PathVariable Integer orderId){
        return orderService.declineOrder(orderId);
    }

    @PostMapping("confirmOrder/{orderId}")
    public ResponseEntity<?> confirmOrder(@PathVariable Integer orderId){
        return orderService.confirmOrder(orderId);
    }

}