package com.graduationproject.controllers;

import com.graduationproject.DTOs.CommentClassifierDTO;
import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.aiDTOs.AIReviewsDTO;
import com.graduationproject.services.impl.AIService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/AI")
public class AIController {

    @Autowired
    private AIService aiService;

    @PostMapping("get-toxicity")
    public ResponseEntity<Integer> getToxicity(@RequestBody CommentClassifierDTO commentDTO) {
        try {
            Integer toxicValue = aiService.getToxicity(commentDTO);
            return ResponseEntity.ok(toxicValue);
        } catch (Exception e) {
            return ResponseEntity.status(400).body(null);
        }
    }

    @GetMapping("get-all-users")
    public CustomResponse getAllUsers() {
        return aiService.getAllUsers();
    }


    @GetMapping("get-all-reviews")
    public ResponseEntity<List<AIReviewsDTO>> getAllReviews() {
        return aiService.getAllReviews();
    }
}
