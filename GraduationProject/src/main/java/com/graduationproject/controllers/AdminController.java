package com.graduationproject.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controller class for handling admin-related requests.
 */
@RestController
@RequestMapping("api/v1/admin")
@RequiredArgsConstructor
public class AdminController {

    /**
     * Returns a greeting message for the admin.
     * @return ResponseEntity containing a greeting message
     */
    @GetMapping
    public ResponseEntity<String> sayHello(){
        return ResponseEntity.ok("Hi Admin");
    }
}