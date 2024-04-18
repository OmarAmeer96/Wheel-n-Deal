package com.graduationproject.services;

import com.graduationproject.DTOs.*;
import org.springframework.validation.BindingResult;

/**
 * Interface defining authentication-related operations.
 */
public interface AuthenticationService {

    /**
     * Signs up a new user.
     * @param signUpRequest The SignUpRequest containing user details for signup
     * @return A JwtAuthenticationResponse containing authentication details upon successful signup,
     *         or null if signup fails
     */
    JwtAuthenticationResponse signup(SignUpRequest signUpRequest, BindingResult bindingResult);

    /**
     * Signs in a user.
     * @param signInRequest The SignInRequest containing user credentials for signin
     * @return A JwtAuthenticationResponse containing authentication details upon successful signin,
     *         or null if signin fails
     */
    JwtAuthenticationResponse signin(SignInRequest signInRequest);

    /**
     * Refreshes the authentication token.
     * @param refreshTokenRequest The RefreshTokenRequest containing the refresh token for token refresh
     * @return A JwtAuthenticationResponse containing the new authentication token upon successful token refresh,
     *         or null if token refresh fails
     */
    JwtAuthenticationResponse refreshToken(RefreshTokenRequest refreshTokenRequest);
}