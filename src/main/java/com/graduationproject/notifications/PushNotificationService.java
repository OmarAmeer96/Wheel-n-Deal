package com.graduationproject.notifications;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PushNotificationService {

    @Autowired
    private FirebaseMessaging messaging;

    public void sendPushNotification(String token, String title, String message) throws FirebaseMessagingException {
        Message msg = Message.builder()
                .setToken(token)
                .putData("title", title)
                .putData("message", message)
                .build();

        String response = messaging.send(msg);
        System.out.println("Sent message: " + response);
    }
}