package com.graduationproject.services.impl;

import com.graduationproject.repositories.TokenRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
 * Implementation of the LogoutHandler interface to handle user logout by invalidating JWT tokens.
 */
@Service
@RequiredArgsConstructor
public class LogoutHandlerImpl implements LogoutHandler {

    private final TokenRepository tokenRepository;

    /**
     * Logs out the user by invalidating the JWT token.
     * @param request The HTTP request
     * @param response The HTTP response
     * @param authentication The Authentication object representing the current user's authentication
     */
    @Override
    public void logout(HttpServletRequest request,
                       HttpServletResponse response,
                       Authentication authentication ) {
        final String authHeader = request.getHeader("Authorization");
        final String jwt;

        // Check if the Authorization header exists and starts with "Bearer "
        if(!StringUtils.hasText(authHeader) || !org.apache.commons.lang3.StringUtils.startsWith(authHeader,"Bearer ")){
            return;
        }

        // Extract the JWT token from the Authorization header
        jwt = authHeader.substring(7);

        // Invalidate the JWT token by setting it as expired and revoked in the database
        var storedToken = tokenRepository.findByToken(jwt)
                .orElse(null);
        if(storedToken != null){
            storedToken.setExpired(true);
            storedToken.setRevoked(true);
            tokenRepository.save(storedToken);
        }
    }
}