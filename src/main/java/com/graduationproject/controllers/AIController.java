package com.graduationproject.controllers;

import com.graduationproject.DTOs.CommentClassifierDTO;
import com.graduationproject.services.impl.AIService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController

public class AIController {

    @Autowired
    private AIService aiService;

    @PostMapping("/get-toxicity")
    public ResponseEntity<Integer> getToxicity(@RequestBody CommentClassifierDTO commentDTO) {
        try {
            Integer toxicValue = aiService.getToxicity(commentDTO);
            return ResponseEntity.ok(toxicValue);
        } catch (Exception e) {
            return ResponseEntity.status(400).body(null);
        }
    }
}
