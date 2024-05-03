package com.graduationproject.services.impl;


import com.graduationproject.DTOs.CommentClassifierDTO;
import com.graduationproject.repositories.ToxicCommentClassifierClient;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.Map;


@Service
@AllArgsConstructor
public class AIService {

    @Autowired
    private final ToxicCommentClassifierClient classifierClient;
    @Autowired
    private final ObjectMapper objectMapper;

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
}
