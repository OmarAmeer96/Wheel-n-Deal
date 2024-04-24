package com.graduationproject.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controller class for handling commuter-related requests.
 */
@RestController
@RequestMapping("api/v1/commuter")
public class CommuterController {

    /**
     * Returns a greeting message for the commuter.
     * @return ResponseEntity containing a greeting message
     */
    @GetMapping
    public ResponseEntity<String> sayHello(){
        return ResponseEntity.ok("Hi Commuter");
    }
}