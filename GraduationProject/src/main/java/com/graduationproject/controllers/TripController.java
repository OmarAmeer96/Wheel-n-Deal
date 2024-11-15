package com.graduationproject.controllers;

import com.graduationproject.DTOs.TripDTO;
import com.graduationproject.services.impl.TripService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/commuter")
public class TripController {

    private final TripService tripService;

    @PostMapping("create-update/trip")
    public ResponseEntity<Object> PostOrUpdateTrip(@RequestBody TripDTO tripDTO){
        return tripService.postOrUpdateTrip(tripDTO);
    }

    @DeleteMapping("delete-trip/{tripId}")
    public ResponseEntity<Object> deleteTripById(@PathVariable int tripId){
        return tripService.deleteTrip(tripId);
    }

    @GetMapping("findAllTripsById/{commuterId}")
    public ResponseEntity<Object> findAllTripsById(@PathVariable Integer commuterId){
        return tripService.findCommuterTrips(commuterId);
    }

    @GetMapping("findTripOrders/{tripId}")
    public ResponseEntity<Object> findTripOrders(@PathVariable Integer tripId){
        return tripService.findTripOrders(tripId);
    }

    //TODO : see why forbidden
    @PostMapping("cancleTrip/{tripId}")
    public ResponseEntity<Object> cancelTrip(@PathVariable Integer tripId){
        return tripService.cancelTrip(tripId);
    }

}