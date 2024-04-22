package com.graduationproject.controllers;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.TripDTO;
import com.graduationproject.services.impl.TripService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/commuter")
@RequiredArgsConstructor
public class TripController {
    private final TripService tripService;

    @PostMapping("create-update/trip")
    public CustomResponse PostOrUpdateTrip(@RequestBody TripDTO tripDTO){
        return tripService.postOrUpdateTrip(tripDTO);
    }

    @DeleteMapping("delete-trip/{tripId}")
    public CustomResponse deleteTripById(@PathVariable int tripId){
        return tripService.deleteTrip(tripId);
    }
}