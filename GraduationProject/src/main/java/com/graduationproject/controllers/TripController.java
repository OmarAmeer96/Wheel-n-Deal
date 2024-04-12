package com.graduationproject.controllers;

import com.graduationproject.DTOs.TripDTO;
import com.graduationproject.DTOs.TripSearchResultDTO;
import com.graduationproject.services.impl.TripService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/commuter")
@RequiredArgsConstructor
public class TripController {
    private final TripService tripService;

    @PostMapping("create-update/trip")
    public ResponseEntity<String> PostOrUpdateTrip(@RequestBody TripDTO tripDTO){
        return tripService.postOrUpdateTrip(tripDTO);
    }

    @DeleteMapping("delete-trip/{tripId}")
    public String deleteTripById(@PathVariable int tripId){
        return tripService.deleteTrip(tripId);
    }

}
