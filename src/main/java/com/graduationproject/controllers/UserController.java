package com.graduationproject.controllers;

import com.graduationproject.DTOs.*;
import com.graduationproject.entities.User;
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

    @PutMapping("update")
    public CustomResponse updateUserProfile(@ModelAttribute UserProfileDTO userProfileDTO) {
        return userProfileService.updateUserProfile(userProfileDTO);
    }

    @GetMapping("get-normal-user-porfile")
    public CustomResponse getNormalUserProfile(@RequestParam Integer id){
        return userProfileService.getNormalUserProfile(id);
    }

    @DeleteMapping("delete")
    public CustomResponse deleteById(@RequestParam Integer id){
        return userServiceImpl.deleteById(id);
    }

    @PostMapping("search-for-trip/{from}/{to}")
    public CustomResponse searchForTrip(@PathVariable String from, @PathVariable String to){
        return tripService.searchForTrip(from,to);
    }

    @GetMapping("get-commuter-profile/{commuterId}")
    public CustomResponse getCommuterProfile(@PathVariable Integer commuterId){
        return commuterProfileService.getFullCommuterProfile(commuterId);
    }

    @PutMapping("change-password")
    public CustomResponse changePassword(@RequestBody ChangePasswordDTO changePasswordDTO){
        return userProfileService.changePassword(changePasswordDTO);
    }

    @PostMapping("add-address/{userId}")
    public CustomResponse addAddress(@PathVariable Integer userId, @RequestBody AddressDTO addressDTO){
        return userServiceImpl.addAddress(userId,addressDTO);
    }
    @GetMapping("getUserAddresses/{userId}")
    public CustomResponse getAllAddressesForUser(@PathVariable Integer userId) {
        CustomResponse response = userServiceImpl.getAllAddressesResponseForUser(userId);
        return response;
    }

    @GetMapping("/commuters/details")
    public ResponseEntity<List<AiCommuterDto>> getAllCommutersDetails() {
        List<AiCommuterDto> commutersDetails = commuterProfileService.getAllCommutersDetails();
        return ResponseEntity.ok(commutersDetails);
    }


}