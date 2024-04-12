package com.graduationproject.controllers;

import com.graduationproject.DTOs.*;
import com.graduationproject.services.AuthenticationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("api/v1/auth")
@RequiredArgsConstructor
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    @PostMapping("signup")
    public ResponseEntity<JwtAuthenticationResponse> signup(@RequestBody SignUpRequest signUpRequest){
        return ResponseEntity.ok(authenticationService.signup(signUpRequest));
    }

    @PostMapping("signin")
    public ResponseEntity<Optional<JwtAuthenticationResponse>> signin(@RequestBody SignInRequest signInRequest) throws ResponseError {
        return ResponseEntity.ok(authenticationService.signin(signInRequest));
    }

    @PostMapping("refresh")
    public ResponseEntity<JwtAuthenticationResponse> refresh(@RequestBody RefreshTokenRequest refreshTokenRequest) throws ResponseError {
        return ResponseEntity.ok(authenticationService.refreshToken(refreshTokenRequest));
    }
}