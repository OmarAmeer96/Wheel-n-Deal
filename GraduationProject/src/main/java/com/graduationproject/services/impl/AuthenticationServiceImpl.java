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
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
    private final TokenRepository tokenRepository;
    @Autowired
    @Qualifier("JWTServiceImpl")
    private JWTService jwtService;
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

    public ResponseEntity<?> signup(SignUpRequest signUpRequest, BindingResult bindingResult) {
        if (!signUpRequest.getPassword().equals(signUpRequest.getConfirmPassword())) {
            return ResponseEntity.badRequest().body("Passwords do not match.");
        }
        if (bindingResult.hasErrors()) {
            StringBuilder errorMessageBuilder = new StringBuilder("Validation failed. Errors: ");
            for (FieldError error : bindingResult.getFieldErrors()) {
                errorMessageBuilder.append(error.getDefaultMessage()).append("; ");
            }
            String errorMessage = errorMessageBuilder.toString();
            return ResponseEntity.badRequest().body(errorMessage);
        }
        if (userRepository.existsByUsername(signUpRequest.getUsername())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Username already exists.");
        }
        if (userRepository.existsByPhoneNumber(signUpRequest.getPhone())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Phone number already exists.");
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

            return ResponseEntity.ok(responseData);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred while processing the signup request: " + e.getMessage());
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

    public ResponseEntity<?> signin(SignInRequest signinRequest) {
        if (signinRequest.getUsername() == null || signinRequest.getUsername().isEmpty()) {
            return ResponseEntity.badRequest().body("Username is required.");
        }
        if (signinRequest.getPassword() == null || signinRequest.getPassword().isEmpty()) {
            return ResponseEntity.badRequest().body("Password is required.");
        }
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(signinRequest.getUsername(), signinRequest.getPassword())
            );
            var user = userRepository.findByUsername(signinRequest.getUsername())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid Username or password"));

            var jwt = jwtService.generateToken(user);
            var refreshToken = jwtService.generateRefreshToken(new HashMap<>(), user);

            Map<String, String> responseData = new HashMap<>();
            responseData.put("stripeId", user.getStripeId());
            responseData.put("token", jwt);
            responseData.put("refreshToken", refreshToken);

            revokeAllUserTokens(user);
            saveUserToken(user, jwt);

            return ResponseEntity.ok()
                    .body(Map.of(
                            "message", "Authentication successful.",
                            "data", responseData
                    ));

        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Map.of("message", "Authentication failed: " + e.getMessage()));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "An error occurred during authentication: " + e.getMessage()));
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

    public ResponseEntity<?> refreshToken(RefreshTokenRequest refreshTokenRequest) {
        try {
            String userEmail = jwtService.extractUserName(refreshTokenRequest.getToken());
            User user = userRepository.findByUsername(userEmail).orElseThrow(() ->
                    new IllegalArgumentException("User not found"));

            if (jwtService.isTokenValid(refreshTokenRequest.getToken(), user)) {
                var jwt = jwtService.generateToken(user);

                Map<String, String> responseData = new HashMap<>();
                responseData.put("token", jwt);
                responseData.put("refreshToken", refreshTokenRequest.getToken());

                return ResponseEntity.ok()
                        .body(Map.of("data", responseData));
            }
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Map.of("message", "Invalid refresh token"));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", e.getMessage()));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "An error occurred during token refresh: " + e.getMessage()));
        }
    }

}