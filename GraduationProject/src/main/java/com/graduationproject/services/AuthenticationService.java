package com.graduationproject.services;

import com.graduationproject.DTOs.*;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.validation.BindingResult;

@Repository
public interface AuthenticationService {
    ResponseEntity<?> signup(SignUpRequest signUpRequest, BindingResult bindingResult);
    ResponseEntity<?> signin(SignInRequest signInRequest);
    ResponseEntity<?> refreshToken(RefreshTokenRequest refreshTokenRequest);
}