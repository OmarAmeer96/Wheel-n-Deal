package com.graduationproject.services.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.graduationproject.DTOs.paymobPaymentDTOs.PayResponseDTO;
import com.graduationproject.DTOs.paymobPaymentDTOs.SecondRequest;
import com.graduationproject.DTOs.paymobPaymentDTOs.ThirdRequest;
import com.graduationproject.DTOs.paymobPaymentDTOs.WalletRequest;
import com.graduationproject.entities.PaymobResponse;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.PaymobResponseRepository;
import com.graduationproject.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

/**
 * Service class for handling payment operations using the Paymob API.
 */
@Service
public class PaymobServiceImpl {

    @Autowired
    private PaymobResponseRepository paymobResponseRepository;

    @Autowired
    private UserRepository userRepository;

    /**
     * Obtains an authentication token from the Paymob API using the provided API key.
     *
     * @param apiKey The API key for authentication
     * @return The authentication token
     * @throws JsonProcessingException If an error occurs during JSON processing
     */
    public String getAuthToken(String apiKey) throws JsonProcessingException {
        // API endpoint for obtaining authentication token
        String url = "https://accept.paymob.com/api/auth/tokens";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // Construct the JSON request body
        String requestJson = "{\"api_key\": \"" + apiKey + "\"}";

        HttpEntity<String> request = new HttpEntity<>(requestJson, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);

        if (response.getStatusCode() == HttpStatus.CREATED) {
            // Parse the JSON response to extract the authentication token
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            return jsonNode.get("token").asText();
        } else {
            return "Error occurred: " + response.getStatusCode();
        }
    }

    /**
     * Creates an ecommerce order using the Paymob API.
     *
     * @param secondRequest The request DTO containing order details
     * @return The ID of the created order
     * @throws JsonProcessingException If an error occurs during JSON processing
     */
    public String createEcommerceOrder(SecondRequest secondRequest) throws JsonProcessingException {
        String orderUrl = "https://accept.paymob.com/api/ecommerce/orders";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(secondRequest.getAuth_token());

        HttpEntity<SecondRequest> requestEntity = new HttpEntity<>(secondRequest, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(orderUrl, requestEntity, String.class);

        if (response.getStatusCode() == HttpStatus.CREATED) {
            // Parse the JSON response to extract the order ID
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            return jsonNode.get("id").asText();
        } else {
            return "Error occurred: " + response.getStatusCode();
        }
    }

    /**
     * Sends a payment key request to the Paymob API.
     *
     * @param thirdRequest The request DTO containing payment details
     * @return The payment token received from the API
     * @throws JsonProcessingException If an error occurs during JSON processing
     */
    public String sendPaymentKeyRequest(ThirdRequest thirdRequest) throws JsonProcessingException {
        String paymentKeyUrl = "https://accept.paymob.com/api/acceptance/payment_keys";

        // Set request headers
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(thirdRequest.getAuth_token());

        // Create HTTP request entity
        HttpEntity<ThirdRequest> request = new HttpEntity<>(thirdRequest, headers);

        // Send POST request to the API endpoint
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(paymentKeyUrl, request, String.class);

        // Process the response
        if (response.getStatusCode() == HttpStatus.CREATED) {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            return jsonNode.get("token").asText();
        } else {
            return "Error occurred: " + response.getStatusCode();
        }
    }

    /**
     * Saves the payment response to the database.
     *
     * @param payResponse The payment response DTO to be saved
     */
    public void savePayResponse(PayResponseDTO payResponse) {
        PaymobResponse responseEntity = new PaymobResponse();
        responseEntity.setExternalId(payResponse.getId());
        responseEntity.setPending(payResponse.isPending());
        responseEntity.setAmountCents(Math.toIntExact(payResponse.getAmount_cents()));
        responseEntity.setCurrency(payResponse.getCurrency());

        paymobResponseRepository.save(responseEntity);
    }

    /**
     * Sends a payment request to the Paymob API.
     *
     * @param walletRequest The request DTO containing payment details
     * @return The payment response DTO received from the API
     */
    public PayResponseDTO sendPaymentRequest(WalletRequest walletRequest) {
        String paymentUrl = "https://accept.paymob.com/api/acceptance/payments/pay";

        // Set request headers
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(walletRequest.getPayment_token());

        // Create HTTP request entity
        HttpEntity<WalletRequest> request = new HttpEntity<>(walletRequest, headers);

        // Send POST request to the API endpoint
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(paymentUrl, request, String.class);

        // Process the response
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            PayResponseDTO walletResponse = objectMapper.readValue(response.getBody(), PayResponseDTO.class);
            String phoneNumber = walletResponse.getSource_data().getPhone_number();
            User user = userRepository.findByPhoneNumber(phoneNumber);
            if (user != null) {
                user.setAmount(user.getAmount() + walletResponse.getAmount_cents() / 100);
                userRepository.save(user);
            }
            savePayResponse(walletResponse);
            return walletResponse;
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }
    }
}