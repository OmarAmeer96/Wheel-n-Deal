package com.graduationproject.controllers;

import com.graduationproject.DTOs.NormalProfileDTO;
import com.graduationproject.DTOs.UserProfileDTO;
import com.graduationproject.services.impl.UserProfileService;
import com.graduationproject.services.impl.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/user")
@RequiredArgsConstructor
public class UserController {
    private final UserProfileService userProfileService;
    private final UserServiceImpl userServiceImpl;

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
}
