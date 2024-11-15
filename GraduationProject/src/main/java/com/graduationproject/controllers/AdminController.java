package com.graduationproject.controllers;

import com.graduationproject.entities.Role;
import com.graduationproject.services.impl.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/admin")
public class AdminController {

    private final UserServiceImpl userService;

    @GetMapping("users")
    public ResponseEntity<?> findUsersByRole(@RequestParam Role role) {
        return userService.findUsersByRole(role);
    }

    @GetMapping("users/count")
    public ResponseEntity<?> countUsersByRole(@RequestParam Role role) {
        return userService.countUsersByRole(role);
    }

}