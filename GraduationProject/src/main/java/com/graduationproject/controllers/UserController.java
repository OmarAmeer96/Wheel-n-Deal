package com.graduationproject.controllers;

import com.graduationproject.DTOs.CommuterProfileDTO;
import com.graduationproject.DTOs.NormalProfileDTO;
import com.graduationproject.DTOs.TripSearchResultDTO;
import com.graduationproject.DTOs.UserProfileDTO;
import com.graduationproject.services.impl.CommuterProfileService;
import com.graduationproject.services.impl.TripService;
import com.graduationproject.services.impl.UserProfileService;
import com.graduationproject.services.impl.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/user")
public class UserController {
    private final UserProfileService userProfileService;
    private final UserServiceImpl userServiceImpl;
    private final TripService tripService;
    private final CommuterProfileService commuterProfileService;

    /**
     * Endpoint to test the controller
     * @return ResponseEntity<String>
     */
    @GetMapping
    public ResponseEntity<String> sayHello(){
        return ResponseEntity.ok("Hi User");
    }

    /**
     * Endpoint to update user profile
     * @param userProfileDTO The user profile DTO containing updated profile information
     * @return ResponseEntity<String>
     */
    @PutMapping("update")
    public ResponseEntity<String> updateUserProfile(@ModelAttribute UserProfileDTO userProfileDTO) {
        return userProfileService.updateUserProfile(userProfileDTO);
    }

    /**
     * Endpoint to retrieve normal user profile details
     * @param id The user ID
     * @return ResponseEntity<NormalProfileDTO>
     */
    @GetMapping("get-normal-user-porfile")
    public ResponseEntity<NormalProfileDTO> getNormalUserProfile(@RequestParam Integer id){
        return userProfileService.getNormalUserProfile(id);
    }

    /**
     * Endpoint to delete user by ID
     * @param id The user ID
     * @return ResponseEntity<String>
     */
    @DeleteMapping("delete")
    public ResponseEntity<String> deleteById(@RequestParam Integer id){
        return userServiceImpl.deleteById(id);
    }

    /**
     * Endpoint to search for trip
     * @param from The origin of the trip
     * @param to The destination of the trip
     * @return ResponseEntity<List<TripSearchResultDTO>>
     */
    @PostMapping("search-for-trip/{from}/{to}")
    public ResponseEntity<List<TripSearchResultDTO>> searchForTrip(@PathVariable String from, @PathVariable String to){
        return tripService.SearchForTrip(from,to);
    }

    /**
     * Endpoint to retrieve commuter profile by commuter ID
     * @param commuterId The commuter ID
     * @return CommuterProfileDTO
     */
    @GetMapping("get-commuter-profile/{commuterId}")
    public CommuterProfileDTO getCommuterProfile(@PathVariable Integer commuterId){
        return commuterProfileService.getFullCommuterProfile(commuterId);
    }
}