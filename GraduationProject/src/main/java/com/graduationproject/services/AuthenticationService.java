package com.graduationproject.services;

import com.graduationproject.DTOs.*;

import java.util.Optional;

public interface AuthenticationService {
    JwtAuthenticationResponse signup(SignUpRequest signUpRequest);
    Optional<JwtAuthenticationResponse> signin(SignInRequest signinRequest) throws ResponseError;
    JwtAuthenticationResponse refreshToken(RefreshTokenRequest refreshTokenRequest) throws ResponseError;
}