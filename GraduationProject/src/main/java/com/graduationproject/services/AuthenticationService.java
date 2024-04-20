package com.graduationproject.services;

import com.graduationproject.DTOs.*;
import org.springframework.stereotype.Repository;
import org.springframework.validation.BindingResult;

@Repository
public interface AuthenticationService {
    JwtAuthenticationResponse signup(SignUpRequest signUpRequest, BindingResult bindingResult);
    JwtAuthenticationResponse signin(SignInRequest signInRequest);
    JwtAuthenticationResponse refreshToken(RefreshTokenRequest refreshTokenRequest);
}