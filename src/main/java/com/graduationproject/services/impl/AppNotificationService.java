package com.graduationproject.services.impl;

import com.graduationproject.entities.AppNotification;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.AppNotificationRepo;
import com.graduationproject.repositories.UserRepository;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AppNotificationService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AppNotificationRepo repo;

    public AppNotification sendNotification(Integer userId, Integer orderId, String message, Integer code){
        User user = userRepository.findById(userId)
                .orElseThrow(()-> new RuntimeException("User Not found"));

        AppNotification appNotification = new AppNotification();
        appNotification.setUser(user);
        appNotification.setOrderId(orderId);
        appNotification.setCode(code);
        appNotification.setMessage(message);
        return repo.save(appNotification);
    }
}
