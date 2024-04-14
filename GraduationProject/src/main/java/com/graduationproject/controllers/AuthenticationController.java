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

/**
 * Controller class for handling authentication-related requests.
 */
@RestController
@RequestMapping("api/v1/auth")
@RequiredArgsConstructor
public class AuthenticationController {

    /** Service for authentication operations. */
    private final AuthenticationService authenticationService;

    /**
     * Handles user signup request.
     * @param signUpRequest SignUpRequest object containing signup details
     * @return ResponseEntity containing JWT authentication response
     */
    @PostMapping("signup")
    public ResponseEntity<JwtAuthenticationResponse> signup(@RequestBody SignUpRequest signUpRequest){
        return ResponseEntity.ok(authenticationService.signup(signUpRequest));
    }

    /**
     * Handles user signin request.
     * @param signInRequest SignInRequest object containing signin details
     * @return ResponseEntity containing optional JWT authentication response
     */
    @PostMapping("signin")
    public ResponseEntity<Optional<JwtAuthenticationResponse>> signin(@RequestBody SignInRequest signInRequest)  {
        return ResponseEntity.ok(authenticationService.signin(signInRequest));
    }

    /**
     * Handles token refresh request.
     * @param refreshTokenRequest RefreshTokenRequest object containing refresh token
     * @return ResponseEntity containing JWT authentication response
     */
    @PostMapping("refresh")
    public ResponseEntity<JwtAuthenticationResponse> refresh(@RequestBody RefreshTokenRequest refreshTokenRequest)  {
        return ResponseEntity.ok(authenticationService.refreshToken(refreshTokenRequest));
    }
}