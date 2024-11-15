package com.graduationproject.controllers;

import com.graduationproject.DTOs.*;
import com.graduationproject.services.impl.CommuterProfileService;
import com.graduationproject.services.impl.TripService;
import com.graduationproject.services.impl.UserProfileService;
import com.graduationproject.services.impl.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/user")
public class UserController {

    private final UserProfileService userProfileService;
    private final UserServiceImpl userServiceImpl;
    private final TripService tripService;
    private final CommuterProfileService commuterProfileService;

    @PutMapping("update")
    public ResponseEntity<Object> updateUserProfile(@ModelAttribute UserProfileDTO userProfileDTO) {
        return userProfileService.updateUserProfile(userProfileDTO);
    }

    @GetMapping("get-normal-user-porfile")
    public ResponseEntity<Object> getNormalUserProfile(@RequestParam Integer id){
        return userProfileService.getNormalUserProfile(id);
    }

    @DeleteMapping("delete")
    public ResponseEntity<String> deleteById(@RequestParam Integer id, @RequestParam String phoneNumber){
        return userServiceImpl.deleteById(id, phoneNumber);
    }

    @PostMapping("search-for-trip/{from}/{to}")
    public ResponseEntity<Object> searchForTrip(@PathVariable String from, @PathVariable String to){
        return tripService.searchForTrip(from,to);
    }

    @GetMapping("get-commuter-profile/{commuterId}")
    public ResponseEntity<Object> getCommuterProfile(@PathVariable Integer commuterId){
        return commuterProfileService.getFullCommuterProfile(commuterId);
    }

    @PutMapping("change-password")
    public ResponseEntity<Object> changePassword(@RequestBody ChangePasswordDTO changePasswordDTO){
        return userProfileService.changePassword(changePasswordDTO);
    }

}