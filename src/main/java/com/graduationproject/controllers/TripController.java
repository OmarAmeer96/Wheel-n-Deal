package com.graduationproject.controllers;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.TripDTO;
import com.graduationproject.DTOs.TripSearchResultDTO;
import com.graduationproject.entities.Order;
import com.graduationproject.entities.Trip;
import com.graduationproject.services.impl.TripService;
import lombok.RequiredArgsConstructor;
import org.aspectj.weaver.ast.Or;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller class for handling commuter trip operations.
 */
@RestController
@RequestMapping("api/v1/commuter")
@RequiredArgsConstructor
public class TripController {
    private final TripService tripService;

    /**
     * Endpoint for creating or updating a commuter trip.
     * @param tripDTO The DTO containing trip details
     * @return ResponseEntity indicating the result of the operation
     */
    @PostMapping("create-update/trip")
    public CustomResponse PostOrUpdateTrip(@RequestBody TripDTO tripDTO){
        return tripService.postOrUpdateTrip(tripDTO);
    }

    /**
     * Endpoint for deleting a commuter trip by ID.
     * @param tripId The ID of the trip to delete
     * @return A string indicating the result of the deletion operation
     */
    @DeleteMapping("delete-trip/{tripId}")
    public CustomResponse deleteTripById(@PathVariable int tripId){
        return tripService.deleteTrip(tripId);
    }

    @GetMapping("findAllTripsById/{commuterId}")
    public CustomResponse findAllTripsById(@PathVariable Integer commuterId){
        return tripService.findCommuterTrips(commuterId);
    }

    @GetMapping("findTripOrders/{tripId}")
    public CustomResponse findTripOrders(@PathVariable Integer tripId){
        return tripService.findTripOrders(tripId);
    }
    //TODO : see why forbidden
    @PostMapping("cancleTrip/{tripId}")
    public CustomResponse cancelTrip(@PathVariable Integer tripId){
        return tripService.cancelTrip(tripId);
    }

    @PostMapping("create-trip-assign-order/{orderId}")
    public CustomResponse createTripAndAssignOrder(@RequestBody TripDTO tripDTO,@PathVariable Integer orderId){
        return tripService.createTripAndAssignOrder(tripDTO,orderId);
    }
}