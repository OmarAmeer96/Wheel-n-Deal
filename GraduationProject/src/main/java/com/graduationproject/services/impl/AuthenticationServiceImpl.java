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
import org.springframework.core.env.Environment;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AuthenticationServiceImpl implements AuthenticationService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JWTService jwtService;
    private final TokenRepository tokenRepository;

    @Autowired
    private Environment env;

    public String createStripeUser(CreateStripeUserRequestDTO request) throws StripeException, JsonProcessingException {
        Stripe.apiKey = env.getProperty("stripe.api.secretKey");

        CustomerCreateParams customerParams = CustomerCreateParams.builder()
                .setPhone(request.getPhoneNumber())
                .setName(request.getUserName())
                .build();

        Customer customer = Customer.create(customerParams);

        Customer customerRetrieve = Customer.retrieve(customer.getId());
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.readTree(customerRetrieve.toJson());
        Map<String, String> customerDetails = new HashMap<>();
        jsonNode.fields().forEachRemaining(entry -> customerDetails.put(entry.getKey(), entry.getValue().asText()));

        return customer.getId();
    }

    public JwtAuthenticationResponse signup(SignUpRequest signUpRequest, BindingResult bindingResult) {

        if (bindingResult.hasErrors()) {
            StringBuilder errorMessageBuilder = new StringBuilder("Validation failed. Errors: ");
            for (FieldError error : bindingResult.getFieldErrors()) {
                errorMessageBuilder.append(error.getDefaultMessage()).append("; ");
            }
            String errorMessage = errorMessageBuilder.toString();

            return JwtAuthenticationResponse.builder()
                    .status(400) // Bad request
                    .message(errorMessage)
                    .build();
        }

        try {
            CreateStripeUserRequestDTO request = new CreateStripeUserRequestDTO();
            request.setPhoneNumber(signUpRequest.getPhone());
            request.setUserName(signUpRequest.getUsername());
            String stripeId = createStripeUser(request);

            User user = new User();
            user.setPhoneNumber(signUpRequest.getPhone());
            user.setUsername(signUpRequest.getUsername());
            user.setRole(signUpRequest.getRole());
            user.setPassword(passwordEncoder.encode(signUpRequest.getPassword()));
            user.setStripeId(stripeId);
            user.setAmount(0L);

            var savedUser = userRepository.save(user);
            var jwtToken = jwtService.generateToken(user);
            var jwtRefreshToken = jwtService.generateRefreshToken(new HashMap<>(), user);
            saveUserToken(savedUser, jwtToken);

            Map<String, String> responseData = new HashMap<>();
            responseData.put("stripeId", stripeId);
            responseData.put("token", jwtToken);
            responseData.put("refreshToken", jwtRefreshToken);

            return JwtAuthenticationResponse.builder()
                    .status(200) // Assuming success status code is 200
                    .message("Request processed successfully.")
                    .data(responseData)
                    .build();
        } catch (Exception e) {
            return JwtAuthenticationResponse.builder()
                    .status(500) // Internal server error
                    .message("An error occurred while processing the request.")
                    .build();
        }
    }

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

    public JwtAuthenticationResponse signin(SignInRequest signinRequest) {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(signinRequest.getUsername(),
                    signinRequest.getPassword()));

            var user = userRepository.findByUsername(signinRequest.getUsername())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid Username or password"));

            var jwt = jwtService.generateToken(user);
            var refreshToken = jwtService.generateRefreshToken(new HashMap<>(), user);

            Map<String, String> responseData = new HashMap<>();
            responseData.put("stripeId", user.getStripeId());
            responseData.put("token", jwt);
            responseData.put("refreshToken", refreshToken);

            return JwtAuthenticationResponse.builder()
                    .status(200) // Assuming success status code is 200
                    .message("Authentication successful.")
                    .data(responseData)
                    .build();

        } catch (Exception e) {
            return JwtAuthenticationResponse.builder()
                    .status(401) // Unauthorized
                    .message("Authentication failed: " + e.getMessage())
                    .build();
        }
    }

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

    public JwtAuthenticationResponse refreshToken(RefreshTokenRequest refreshTokenRequest) {
        String userEmail = jwtService.extractUserName(refreshTokenRequest.getToken());
        User user = userRepository.findByUsername(userEmail).orElseThrow();
        if (jwtService.isTokenValid(refreshTokenRequest.getToken(), user)) {
            var jwt = jwtService.generateToken(user);

            Map<String, String> responseData = new HashMap<>();
            responseData.put("token", jwt);
            responseData.put("refreshToken", refreshTokenRequest.getToken());

            return JwtAuthenticationResponse.builder()
                    .status(200) // Assuming success status code is 200
                    .message("Authentication successful.")
                    .data(responseData)
                    .build();
        }
        return JwtAuthenticationResponse.builder().build();
    }
}