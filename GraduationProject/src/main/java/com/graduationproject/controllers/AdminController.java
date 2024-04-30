package com.graduationproject.controllers;

import com.graduationproject.DTOs.UserDTO;
import com.graduationproject.entities.Role;
import com.graduationproject.services.impl.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/admin")
@RequiredArgsConstructor
public class AdminController {
    private final UserServiceImpl userService;
    @GetMapping("/users")
    public List<UserDTO> findUsersByRole(@RequestParam Role role) {
        return userService.findUsersByRole(role);
    }
    @GetMapping("/users/count")
    public long countUsersByRole(@RequestParam Role role) {
        return userService.countUsersByRole(role);
    }
}