package com.graduationproject.services.impl;

import com.graduationproject.entities.Order;
import com.graduationproject.entities.PromoCode;
import com.graduationproject.entities.PromocodeStatus;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.OrderRepository;
import com.graduationproject.repositories.PromoCodeRepository;
import com.graduationproject.repositories.UserRepository;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.Random;

@Data
@Service
@RequiredArgsConstructor
public class PromocodeService {

    private final OrderRepository orderRepository;

    private final UserRepository userRepository;

    private final PromoCodeRepository promoCodeRepository;
    //here I used orderId not userId to get the discount amount
    //based on the order price
    public void generatePromoCode(Integer orderId){
        Optional<Order> optionalOrder= orderRepository.findById(orderId);
        if (optionalOrder.isPresent()){
            Order existingOrder = optionalOrder.get();
            User user = existingOrder.getUser();
            String code = generateRandomString(15);
            double discountAmount = existingOrder.getExpectedPrice() * 0.1;

            PromoCode promoCode = new PromoCode();
            promoCode.setUser(user);
            promoCode.setPromocodeStatus(PromocodeStatus.ACTIVE);
            promoCode.setPromoCode(code);
            promoCode.setDiscountAmount(discountAmount);

            promoCodeRepository.save(promoCode);
        }
    }

    public Boolean checkPromoCode(String promoCode){
        PromoCode promoCode1 = promoCodeRepository.findByPromoCode(promoCode);
        return promoCode1 != null ;
    }

    private static String generateRandomString(int length) {
        // Define characters allowed in the random string
        String allowedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

        // Create a StringBuilder to store the random string
        StringBuilder randomString = new StringBuilder();

        // Create an instance of Random class
        Random random = new Random();

        // Generate random characters until the desired length is reached
        for (int i = 0; i < length; i++) {
            // Generate a random index within the range of allowedChars
            int randomIndex = random.nextInt(allowedChars.length());

            // Append the character at the random index to the randomString
            randomString.append(allowedChars.charAt(randomIndex));
        }

        // Convert StringBuilder to String and return
        return randomString.toString();
    }


}
