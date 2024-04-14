package com.graduationproject.controllers;

import com.graduationproject.DTOs.*;
import com.graduationproject.services.AuthenticationService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
     * @return JwtAuthenticationResponse containing JWT authentication response,
     *         or null if signup fails
     */
    @PostMapping("signup")
    public JwtAuthenticationResponse signup(@RequestBody SignUpRequest signUpRequest){
        return authenticationService.signup(signUpRequest);
    }

    /**
     * Handles user signin request.
     * @param signInRequest SignInRequest object containing signin details
     * @return JwtAuthenticationResponse containing JWT authentication response,
     *         or null if signin fails
     */
    @PostMapping("signin")
    public JwtAuthenticationResponse signin(@RequestBody SignInRequest signInRequest)  {
        return authenticationService.signin(signInRequest);
    }

    /**
     * Handles token refresh request.
     * @param refreshTokenRequest RefreshTokenRequest object containing refresh token
     * @return JwtAuthenticationResponse containing JWT authentication response,
     *         or null if token refresh fails
     */
    @PostMapping("refresh")
    public JwtAuthenticationResponse refresh(@RequestBody RefreshTokenRequest refreshTokenRequest)  {
        return authenticationService.refreshToken(refreshTokenRequest);
    }
}