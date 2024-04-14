package com.graduationproject.services;

import com.graduationproject.DTOs.*;

import java.util.Optional;

/**
 * Interface defining authentication-related operations.
 */
public interface AuthenticationService {

    /**
     * Signs up a new user.
     * @param signUpRequest The SignUpRequest containing user details for signup
     * @return A JwtAuthenticationResponse containing authentication details upon successful signup
     */
    JwtAuthenticationResponse signup(SignUpRequest signUpRequest);

    /**
     * Signs in a user.
     * @param signInRequest The SignInRequest containing user credentials for signin
     * @return An Optional JwtAuthenticationResponse containing authentication details upon successful signin,
     *         or an empty Optional if signin fails
     */
    Optional<JwtAuthenticationResponse> signin(SignInRequest signInRequest);

    /**
     * Refreshes the authentication token.
     * @param refreshTokenRequest The RefreshTokenRequest containing the refresh token for token refresh
     * @return A JwtAuthenticationResponse containing the new authentication token upon successful token refresh
     */
    JwtAuthenticationResponse refreshToken(RefreshTokenRequest refreshTokenRequest);
}