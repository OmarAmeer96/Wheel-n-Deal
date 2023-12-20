package com.GraduationProject.test.controllers;

import com.GraduationProject.test.DTOs.LoginDTO;
import com.GraduationProject.test.DTOs.UserDTO;
import com.GraduationProject.test.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("api/v1/users")
public class UserController {
    @Autowired
    private UserService userService;
    @PostMapping("/save")
    public void saveUser(@RequestBody UserDTO userDTO)
    {
        userService.addUser(userDTO);
    }
    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody LoginDTO loginDTO)
    {
        return ResponseEntity.ok(userService.loginUser(loginDTO));
    }
}

