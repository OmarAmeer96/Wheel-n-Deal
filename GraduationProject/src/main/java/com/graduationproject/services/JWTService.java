package com.graduationproject.services;

import org.springframework.security.core.userdetails.UserDetails;

import java.util.HashMap;

/**
 * Interface defining operations related to JSON Web Tokens (JWT).
 */
public interface JWTService {

    /**
     * Extracts the username from a JWT token.
     * @param token The JWT token from which to extract the username
     * @return The extracted username
     */
    String extractUserName(String token);

    /**
     * Generates a JWT token for the provided UserDetails.
     * @param userDetails The UserDetails object representing the user for whom the token is generated
     * @return The generated JWT token
     */
    String generateToken(UserDetails userDetails);

    /**
     * Checks if a JWT token is valid for the given UserDetails.
     * @param token The JWT token to validate
     * @param userDetails The UserDetails object representing the user for whom the token is being validated
     * @return true if the token is valid for the given user, false otherwise
     */
    boolean isTokenValid(String token, UserDetails userDetails);

    /**
     * Generates a refresh token with optional extra claims for the provided UserDetails.
     * @param extraClaims Additional claims to include in the refresh token
     * @param userDetails The UserDetails object representing the user for whom the refresh token is generated
     * @return The generated refresh token
     */
    String generateRefreshToken(HashMap<String, Object> extraClaims, UserDetails userDetails);
}