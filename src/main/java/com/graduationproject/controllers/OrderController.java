package com.graduationproject.controllers;

import com.graduationproject.DTOs.*;
import com.graduationproject.entities.Order;
import com.graduationproject.services.impl.OrderService;
import com.graduationproject.services.impl.PromocodeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("api/v1/user")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;
    private final PromocodeService promocodeService;

    @PostMapping("create-update")
    public CustomResponse createOrder(@ModelAttribute OrderDTO orderDTO) {
        return orderService.createOrUpdateOrder(orderDTO);
    }

    @GetMapping("searchOrders/{from}/{to}")
    public CustomResponse searchOrder(@PathVariable String from, @PathVariable String to){
        return orderService.searchForOrder(from,to);
    }

    @GetMapping("findAll/{userId}")
    public CustomResponse findAllByUserId(@PathVariable Integer userId){
        return orderService.findAllByUserId(userId);
    }

    @GetMapping("find-not-active/{userId}")
    public CustomResponse findNotActiveOrders(@PathVariable Integer userId){
        return orderService.findNotActiveOrders(userId);
    }



    /**
     * This is used for both assigning order to trip and vice versa
    */
    @PostMapping("/assign-existing-order/{orderId}/{tripId}")
    public CustomResponse assignExistingOrder(@PathVariable Integer orderId,@PathVariable Integer tripId){
        return orderService.assignExistingOrder(orderId,tripId);
    }
    //here I create order and assigned it to the commuter but make the order not active yet
    //when The commuter Accept it becomes active(pending) and the commuter moves to take it
    @PostMapping("create-and-assign/{tripId}")
    public CustomResponse createOrderAndAssignIt(@ModelAttribute OrderDTO orderDTO,@PathVariable Integer tripId){
        return orderService.createOrderAndAssignIt(orderDTO,tripId);
    }
    @PostMapping("cancel-order/{orderId}/{canclerId}")
    public CustomResponse cancleOrder(@PathVariable Integer orderId,@PathVariable Integer canclerId){
        return orderService.cancleOrder(orderId,canclerId);
    }


    //TODO : handle the security stuff to make this endpoint only allowed for commuter
    // (must use commuter token and make sure that the id in the token is the same one that the will be passed)
    @PostMapping("findCommuterOrders/{commuterId}")
    public CustomResponse findCommuterOrders(@PathVariable Integer commuterId){
        return orderService.findCommuterOrders(commuterId);
    }

    @PostMapping("negotiate")
    public CustomResponse negotiate(@RequestBody NegotiationDTO negotiationDTO){
        return orderService.negotiate(negotiationDTO);
    }

    @PostMapping("pickOrder")
    public CustomResponse pickOrder(@RequestBody OrderPickDTO orderPickDTO){
        return orderService.pickOrder(orderPickDTO);
    }


    @GetMapping("getOrderApplicants/{orderId}")
    public CustomResponse getOrderApplicants(@PathVariable Integer orderId) {
        return orderService.getOrderApplicants(orderId);
    }

    @PostMapping("confirmPickingUp")
    public CustomResponse confirmPickingUp(@RequestBody ConfirmPickingUpDTO confirmPickingUpDTO){
        return orderService.confirmPickingUp(confirmPickingUpDTO);
    }

    @GetMapping("findOrderById/{orderId}")
    public CustomResponse findorderById(@PathVariable Integer orderId){
        return orderService.findById(orderId);
    }

    @PostMapping("declineOrder/{orderId}")
    public CustomResponse declineOrder(@PathVariable Integer orderId){
        return orderService.declineOrder(orderId);
    }

    @PostMapping("confirmOrder/{orderId}")
    public CustomResponse confirmOrder(@PathVariable Integer orderId){
        return orderService.confirmOrder(orderId);
    }

    @DeleteMapping("deleteOrder/{orderId}")
    public CustomResponse deleteOrder(@PathVariable Integer orderId){
        return orderService.deleteOrder(orderId);
    }

}