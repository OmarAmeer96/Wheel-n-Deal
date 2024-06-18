package com.graduationproject.controllers;

import com.graduationproject.DTOs.*;
import com.graduationproject.services.AuthenticationService;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController
@RequestMapping("api/v1/auth")
@RequiredArgsConstructor
public class AuthenticationController {

    private final AuthenticationService authenticationService;
    @PostMapping("signup")
    public JwtAuthenticationResponse signup(@Validated @RequestBody SignUpRequest signUpRequest, BindingResult bindingResult) {
        return authenticationService.signup(signUpRequest, bindingResult);
    }

    @PostMapping("signin")
    public JwtAuthenticationResponse signin(@RequestBody SignInRequest signInRequest)  {
        return authenticationService.signin(signInRequest);
    }

    @PostMapping("refresh")
    public JwtAuthenticationResponse refresh(@RequestBody RefreshTokenRequest refreshTokenRequest)  {
        return authenticationService.refreshToken(refreshTokenRequest);
    }
}