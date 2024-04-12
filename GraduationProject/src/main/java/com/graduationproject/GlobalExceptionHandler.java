package com.graduationproject;

import com.graduationproject.DTOs.ResponseError;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ResponseError> handleException(Exception ex) {
        ResponseError error = new ResponseError(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage(), ex.getClass().getName());
        return new ResponseEntity<>(error, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ResponseError> handleIllegalArgumentException(IllegalArgumentException ex) {
        ResponseError error = new ResponseError(HttpStatus.BAD_REQUEST, ex.getMessage(), ex.getClass().getName());
        return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
    }
}

