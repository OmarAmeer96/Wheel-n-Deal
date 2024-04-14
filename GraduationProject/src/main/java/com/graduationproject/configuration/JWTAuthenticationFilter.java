package com.graduationproject.configuration;

import com.graduationproject.repositories.TokenRepository;
import com.graduationproject.services.JWTService;
import com.graduationproject.services.UserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

/**
 * Filter to handle JWT-based authentication.
 * This filter intercepts incoming requests and checks for a JWT token in the Authorization header.
 * If a valid JWT token is found, it retrieves the user details from the token and sets the authentication in the security context.
 */
@Component
@RequiredArgsConstructor
public class JWTAuthenticationFilter extends OncePerRequestFilter {

    private final JWTService jwtService;

    private final UserService userService;

    private final TokenRepository tokenRepository;

    /**
     * Method to intercept incoming requests, extract JWT token from Authorization header,
     * validate the token, and set authentication in security context if valid.
     * @param request HttpServletRequest object representing the incoming request
     * @param response HttpServletResponse object representing the response to be sent
     * @param filterChain FilterChain object to pass the request and response to the next filter in the chain
     * @throws ServletException If an error occurs during request processing
     * @throws IOException If an I/O error occurs during request processing
     */
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        final String authHeader = request.getHeader("Authorization");
        final String jwt;
        final String userEmail;

        // Check if Authorization header exists and starts with "Bearer "
        if(!StringUtils.hasText(authHeader) || !org.apache.commons.lang3.StringUtils.startsWith(authHeader,"Bearer ")){
            filterChain.doFilter(request,response);
            return;
        }

        // Extract JWT token from Authorization header
        jwt = authHeader.substring(7);
        userEmail=jwtService.extractUserName(jwt);

        // Check if user email exists and user is not already authenticated
        if(StringUtils.hasText(userEmail) && SecurityContextHolder.getContext().getAuthentication()==null){
            // Load user details from user service
            UserDetails userDetails = userService.userDetailsService().loadUserByUsername(userEmail);

            // Check if token is valid and not expired or revoked
            var isTokenValid = tokenRepository.findByToken(jwt)
                    .map(token -> !token.isExpired() && !token.isRevoked())
                    .orElse(false);
            if(jwtService.isTokenValid(jwt, userDetails) && isTokenValid){
                // Set authentication in security context
                SecurityContext securityContext = SecurityContextHolder.createEmptyContext();
                UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(
                        userDetails, null, userDetails.getAuthorities()
                );
                token.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                securityContext.setAuthentication(token);
                SecurityContextHolder.setContext(securityContext);
            }
        }

        // Pass request and response to the next filter in the chain
        filterChain.doFilter(request,response);
    }
}