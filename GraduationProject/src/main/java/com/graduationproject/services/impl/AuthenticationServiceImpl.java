package com.graduationproject.services.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.graduationproject.DTOs.*;
import com.graduationproject.DTOs.stripePaymentDTOs.CreateStripeUserRequestDTO;
import com.graduationproject.entities.Token;
import com.graduationproject.entities.TokenType;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.TokenRepository;
import com.graduationproject.repositories.UserRepository;
import com.graduationproject.services.AuthenticationService;
import com.graduationproject.services.JWTService;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Customer;
import com.stripe.param.CustomerCreateParams;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Service implementation for user authentication operations.
 */
@Service
@RequiredArgsConstructor
public class AuthenticationServiceImpl implements AuthenticationService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JWTService jwtService;
    private final TokenRepository tokenRepository;

    /**
     * Creates a new customer in Stripe and saves user details in the database.
     * @param request The DTO containing the request details
     * @return The Stripe ID of the created customer
     * @throws StripeException if an error occurs with the Stripe API
     * @throws JsonProcessingException if an error occurs while processing JSON
     */
    public String createStripeUser(CreateStripeUserRequestDTO request) throws StripeException, JsonProcessingException {
        // Set the API key for Stripe
        Stripe.apiKey = "sk_test_51Of0HSDRpAtfI02p07kURFyWFuON9GhxXSEzZNxRpbVqLXc83KH0JcMjeURgkwf6UXsD9Xm7Z7sVf3g9tFC2Gdeo00fPYbS9G6";

        // Create customer parameters
        CustomerCreateParams customerParams = CustomerCreateParams.builder()
                .setPhone(request.getPhoneNumber())
                .setName(request.getUserName())
                .build();

        // Create a new customer in Stripe
        Customer customer = Customer.create(customerParams);

        // Retrieve customer details
        Customer customerRetrieve = Customer.retrieve(customer.getId());
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.readTree(customerRetrieve.toJson());
        Map<String, String> customerDetails = new HashMap<>();
        jsonNode.fields().forEachRemaining(entry -> customerDetails.put(entry.getKey(), entry.getValue().asText()));

        // Save user details in the database
        User userEntity = new User();
        userEntity.setStripeId(customer.getId());
        userEntity.setPhoneNumber(request.getPhoneNumber());
        userEntity.setUsername(request.getUserName());
        userEntity.setAmount(0L);
        userRepository.save(userEntity);

        return customer.getId();
    }

    /**
     * Handles user signup operation.
     * @param signUpRequest The DTO containing signup details
     * @return The JWT authentication response containing token and refresh token
     */
    public JwtAuthenticationResponse signup(SignUpRequest signUpRequest) {
        try {
            CreateStripeUserRequestDTO request = new CreateStripeUserRequestDTO();
            request.setPhoneNumber(signUpRequest.getPhone());
            request.setUserName(signUpRequest.getUsername());

            User user = new User();
            user.setPhoneNumber(signUpRequest.getPhone());
            user.setUsername(signUpRequest.getUsername());
            user.setRole(signUpRequest.getRole());
            user.setPassword(passwordEncoder.encode(signUpRequest.getPassword()));

            var savedUser = userRepository.save(user);
            var jwtToken = jwtService.generateToken(user);
            var jwtRefreshToken = jwtService.generateRefreshToken(new HashMap<>(), user);
            saveUserToken(savedUser, jwtToken);

            // Return a success response with tokens
            return JwtAuthenticationResponse.builder()
                    .token(jwtToken)
                    .refreshToken(jwtRefreshToken)
                    .success(true)
                    .stripeId(createStripeUser(request))
                    .build();
        } catch (Exception e) {
            // If an exception occurs, return a failure response
            return JwtAuthenticationResponse.builder()
                    .success(false)
                    .build();
        }
    }


    /**
     * Saves the user token in the database.
     * @param user The user entity
     * @param jwtToken The JWT token
     */
    private void saveUserToken(User user, String jwtToken) {
        var token = Token.builder()
                .user(user)
                .token(jwtToken)
                .tokenType(TokenType.BEARER)
                .revoked(false)
                .expired(false)
                .build();
        tokenRepository.save(token);
    }

    /**
     * Handles user signin operation.
     * @param signinRequest The DTO containing signin details
     * @return Optional containing JWT authentication response if signin is successful
     */
    public JwtAuthenticationResponse signin(SignInRequest signinRequest) {
        try {
            // Attempt to authenticate the user
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(signinRequest.getUsername(),
                    signinRequest.getPassword()));

            // If authentication succeeds, generate JWT tokens
            var user = userRepository.findByUsername(signinRequest.getUsername())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid Username or password"));

            var jwt = jwtService.generateToken(user);
            var refreshToken = jwtService.generateRefreshToken(new HashMap<>(), user);

            // Save the tokens and return a success response
            JwtAuthenticationResponse jwtAuthenticationResponse = new JwtAuthenticationResponse();
            jwtAuthenticationResponse.setToken(jwt);
            jwtAuthenticationResponse.setRefreshToken(refreshToken);
            jwtAuthenticationResponse.setSuccess(true);
            revokeAllUserTokens(user);
            saveUserToken(user, jwt);

            return jwtAuthenticationResponse;
        } catch (Exception e) {
            // If authentication fails, return a failure response
            return JwtAuthenticationResponse.builder().success(false).build();
        }
    }


    /**
     * Revokes all tokens associated with the user.
     * @param user The user entity
     */
    public void revokeAllUserTokens(User user) {
        var validUserTokens = tokenRepository.findAllValidTokensByUser(user.getId());
        if (validUserTokens.isEmpty())
            return;
        validUserTokens.forEach(token -> {
            token.setExpired(true);
            token.setRevoked(true);
        });
        tokenRepository.saveAll(validUserTokens);
    }

    /**
     * Handles token refresh operation.
     * @param refreshTokenRequest The DTO containing refresh token
     * @return The refreshed JWT authentication response
     */
    public JwtAuthenticationResponse refreshToken(RefreshTokenRequest refreshTokenRequest) {
        String userEmail = jwtService.extractUserName(refreshTokenRequest.getToken());
        User user = userRepository.findByUsername(userEmail).orElseThrow();
        if (jwtService.isTokenValid(refreshTokenRequest.getToken(), user)) {
            var jwt = jwtService.generateToken(user);

            JwtAuthenticationResponse jwtAuthenticationResponse = new JwtAuthenticationResponse();
            jwtAuthenticationResponse.setToken(jwt);
            jwtAuthenticationResponse.setRefreshToken(refreshTokenRequest.getToken());
            jwtAuthenticationResponse.setSuccess(true);

            return jwtAuthenticationResponse;
        }
        return JwtAuthenticationResponse.builder().success(false).build();
    }
}