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

/**
 * Controller class for managing user-related operations.
 */
@RestController
@RequestMapping("api/v1/user")
@RequiredArgsConstructor
public class UserController {
    private final UserProfileService userProfileService;
    private final UserServiceImpl userServiceImpl;
    private final TripService tripService;
    private final CommuterProfileService commuterProfileService;

    /**
     * Endpoint for saying hello to the user.
     * @return ResponseEntity with a greeting message
     */
    @GetMapping
    public ResponseEntity<String> sayHello(){
        return ResponseEntity.ok("Hi User");
    }

    /**
     * Endpoint for updating user profile.
     * @param userProfileDTO The DTO containing user profile details
     * @return ResponseEntity indicating the result of the update operation
     */
    @PutMapping("update")
    public ResponseEntity<String> updateUserProfile(@ModelAttribute UserProfileDTO userProfileDTO) {
        return userProfileService.updateUserProfile(userProfileDTO);
    }

    /**
     * Endpoint for retrieving normal user profile.
     * @param id The ID of the user
     * @return ResponseEntity containing the normal user profile details
     */
    @GetMapping("get-normal-user-profile")
    public ResponseEntity<NormalProfileDTO> getNormalUserProfile(@RequestParam Integer id){
        return userProfileService.getNormalUserProfile(id);
    }

    /**
     * Endpoint for deleting a user by ID.
     * @param id The ID of the user to delete
     * @return ResponseEntity indicating the result of the deletion operation
     */
    @DeleteMapping("delete")
    public ResponseEntity<String> deleteById(@RequestParam Integer id){
        return userServiceImpl.deleteById(id);
    }

    /**
     * Endpoint for searching trips based on origin and destination.
     * @param from The origin of the trip
     * @param to The destination of the trip
     * @return ResponseEntity containing a list of trip search results
     */
    @PostMapping("search-for-trip/{from}/{to}")
    public ResponseEntity<List<TripSearchResultDTO>> searchForTrip(@PathVariable String from, @PathVariable String to){
        return tripService.SearchForTrip(from,to);
    }

    /**
     * Endpoint for retrieving the full profile of a commuter.
     * @param commuterId The ID of the commuter
     * @return The full commuter profile
     */
    @GetMapping("get-commuter-profile/{commuterId}")
    public CommuterProfileDTO getCommuterProfile(@PathVariable Integer commuterId){
        return commuterProfileService.getFullCommuterProfile(commuterId);
    }
}