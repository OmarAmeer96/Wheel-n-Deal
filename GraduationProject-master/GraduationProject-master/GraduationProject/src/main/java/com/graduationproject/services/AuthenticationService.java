package com.graduationproject.services;

import com.graduationproject.DTOs.JwtAuthenticationResponse;
import com.graduationproject.DTOs.RefreshTokenRequest;
import com.graduationproject.DTOs.SignInRequest;
import com.graduationproject.DTOs.SignUpRequest;

public interface AuthenticationService {
    JwtAuthenticationResponse signup(SignUpRequest signUpRequest);

    JwtAuthenticationResponse signin(SignInRequest signinRequest);

    JwtAuthenticationResponse refreshToken(RefreshTokenRequest refreshTokenRequest);
}
