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
@RequestMapping("api/v1/user")
@RequiredArgsConstructor
public class UserController {
    private final UserProfileService userProfileService;
    private final UserServiceImpl userServiceImpl;

    private final TripService tripService;

    private final CommuterProfileService commuterProfileService;

    @GetMapping
    public ResponseEntity<String> sayHello(){
        return ResponseEntity.ok("Hi User");
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateUserProfile(@ModelAttribute UserProfileDTO userProfileDTO) {
        return userProfileService.updateUserProfile(userProfileDTO);
    }

    @GetMapping("/get-normal-user-porfile")
    public ResponseEntity<NormalProfileDTO> getNormalUserProfile(@RequestParam Integer id){
        return userProfileService.getNormalUserProfile(id);
    }

    @DeleteMapping("/delete")
    public ResponseEntity<String> deleteById(@RequestParam Integer id){
       return userServiceImpl.deleteById(id);
    }

    @PostMapping("/search-for-trip/{from}/{to}")
    public ResponseEntity<List<TripSearchResultDTO>> searchForTrip(@PathVariable String from, @PathVariable String to){
        return tripService.SearchForTrip(from,to);
    }

    @GetMapping("/get-commuter-profile/{commuterId}")
    public CommuterProfileDTO getCommuterProfile(@PathVariable Integer commuterId){
        return commuterProfileService.getFullCommuterProfile(commuterId);
    }
}
