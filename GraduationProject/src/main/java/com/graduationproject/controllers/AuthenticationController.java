package com.graduationproject.controllers;

import com.graduationproject.DTOs.*;
import com.graduationproject.services.AuthenticationService;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/auth")
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    @PostMapping("signup")
    public ResponseEntity<?> signup(@Validated @RequestBody SignUpRequest signUpRequest, BindingResult bindingResult) {
        return authenticationService.signup(signUpRequest, bindingResult);
    }

    @PostMapping("signin")
    public ResponseEntity<?> signin(@RequestBody SignInRequest signInRequest)  {
        return authenticationService.signin(signInRequest);
    }

    @PostMapping("refresh")
    public ResponseEntity<?> refresh(@RequestBody RefreshTokenRequest refreshTokenRequest)  {
        return authenticationService.refreshToken(refreshTokenRequest);
    }

}