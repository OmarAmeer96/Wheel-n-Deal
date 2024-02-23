package com.graduationproject.services.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.graduationproject.DTOs.paymobPaymentDTOs.PayResponseDTO;
import com.graduationproject.DTOs.paymobPaymentDTOs.SecondRequest;
import com.graduationproject.DTOs.paymobPaymentDTOs.ThirdRequest;
import com.graduationproject.DTOs.paymobPaymentDTOs.WalletRequest;
import com.graduationproject.entities.PaymobResponse;
import com.graduationproject.repositories.PaymobResponseRepository;
import com.graduationproject.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class PaymobServiceImpl {

    @Autowired
    private PaymobResponseRepository paymobResponseRepository;

    @Autowired
    private UserRepository userRepository;

    public String getAuthToken(String apiKey) throws JsonProcessingException {
        String url = "https://accept.paymob.com/api/auth/tokens";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String requestJson = "{\"api_key\": \"" + apiKey + "\"}";

        HttpEntity<String> request = new HttpEntity<>(requestJson, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);

        if (response.getStatusCode() == HttpStatus.CREATED) {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            return jsonNode.get("token").asText();
        } else {
            return "Error occurred: " + response.getStatusCode();
        }
    }

    public String createEcommerceOrder(SecondRequest secondRequest) throws JsonProcessingException {
        String orderUrl = "https://accept.paymob.com/api/ecommerce/orders";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(secondRequest.getAuth_token());

        HttpEntity<SecondRequest> requestEntity = new HttpEntity<>(secondRequest, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(orderUrl, requestEntity, String.class);

        if (response.getStatusCode() == HttpStatus.CREATED) {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            return jsonNode.get("id").asText();
        } else {
            return "Error occurred: " + response.getStatusCode();
        }
    }

    public String sendPaymentKeyRequest(ThirdRequest thirdRequest) throws JsonProcessingException {
        String paymentKeyUrl = "https://accept.paymob.com/api/acceptance/payment_keys";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(thirdRequest.getAuth_token());

        HttpEntity<ThirdRequest> request = new HttpEntity<>(thirdRequest, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(paymentKeyUrl, request, String.class);

        if (response.getStatusCode() == HttpStatus.CREATED) {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            return jsonNode.get("token").asText();
        } else {
            return "Error occurred: " + response.getStatusCode();
        }
    }

    public void savePayResponse(PayResponseDTO payResponse) {
        PaymobResponse responseEntity = new PaymobResponse();
        responseEntity.setExternalId(payResponse.getId());
        responseEntity.setPending(payResponse.isPending());
        responseEntity.setAmountCents(Math.toIntExact(payResponse.getAmount_cents()));
        responseEntity.setCurrency(payResponse.getCurrency());

        paymobResponseRepository.save(responseEntity);
    }

    public PayResponseDTO sendPaymentRequest(WalletRequest walletRequest) {
        String paymentUrl = "https://accept.paymob.com/api/acceptance/payments/pay";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(walletRequest.getPayment_token());

        HttpEntity<WalletRequest> request = new HttpEntity<>(walletRequest, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(paymentUrl, request, String.class);

        ObjectMapper objectMapper = new ObjectMapper();
        try {
            PayResponseDTO walletResponse = objectMapper.readValue(response.getBody(), PayResponseDTO.class);
            savePayResponse(walletResponse);
            return walletResponse;
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }
    }
}

