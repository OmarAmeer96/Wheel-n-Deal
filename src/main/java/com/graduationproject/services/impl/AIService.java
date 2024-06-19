package com.graduationproject.services.impl;


import com.graduationproject.DTOs.CommentClassifierDTO;
import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.aiDTOs.AIReviewsDTO;
import com.graduationproject.DTOs.aiDTOs.AIUserDTO;
import com.graduationproject.repositories.ReviewRepository;
import com.graduationproject.repositories.ToxicCommentClassifierClient;
import com.graduationproject.repositories.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;
import java.util.Map;


@Service
@AllArgsConstructor
public class AIService {

    @Autowired
    private final ToxicCommentClassifierClient classifierClient;
    @Autowired
    private final ObjectMapper objectMapper;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ReviewRepository reviewRepository;

    public Integer getToxicity(CommentClassifierDTO comment) throws Exception {
        ResponseEntity<String> response = classifierClient.classifyComment(comment);

        Map<String, Object> responseMap = objectMapper.readValue(response.getBody(), Map.class);

        Map<String, Object> classesMap = (Map<String, Object>) responseMap.get("classes");

        if (classesMap == null) {
            throw new Exception("Invalid response format: 'classes' not found");
        }

        Integer toxicValue = (Integer) classesMap.get("toxic");

        if (toxicValue == null) {
            throw new Exception("Invalid response format: 'toxic' not found");
        }

        return toxicValue;
    }

    public CustomResponse getAllUsers() {
        try {
            List<AIUserDTO> users = userRepository.findAllUserDTOs();
            if (users.isEmpty()) {
                return CustomResponse.builder()
                        .status(204)
                        .message("No users found")
                        .data(null)
                        .build();
            } else {
                return CustomResponse.builder()
                        .status(200)
                        .message("Users retrieved successfully")
                        .data(users)
                        .build();
            }
        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(500)
                    .message("An error occurred: " + e.getMessage())
                    .data(null)
                    .build();
        }
    }


    public ResponseEntity<List<AIReviewsDTO>> getAllReviews() {
        try {
            List<AIReviewsDTO> reviews = reviewRepository.findAllReviewDTOs();
            if (reviews.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } else {
                return new ResponseEntity<>(reviews, HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
