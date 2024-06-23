package com.graduationproject.repositories;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.ResponseEntity;

import com.graduationproject.DTOs.CommentClassifierDTO;

@FeignClient(name = "toxic-comment-classifier", url = "https://comment-classifier-vwprh3aw2a-ww.a.run.app")
public interface ToxicCommentClassifierClient {

    @PostMapping("/")
    ResponseEntity<String> classifyComment(@RequestBody CommentClassifierDTO commentDTO);
}
