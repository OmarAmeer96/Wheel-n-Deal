package com.graduationproject.notifications;

import com.google.firebase.messaging.FirebaseMessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("api/v1/push")
public class PushNotificationController {

    @Autowired
    private PushNotificationService pushNotificationService;

    @Autowired
    private DeviceTokenRepository deviceTokenRepository;

    @PostMapping("/send")
    public ResponseEntity<String> sendPushNotification(@RequestBody PushNotificationRequest request) throws FirebaseMessagingException {
        List<DeviceToken> deviceTokens = deviceTokenRepository.findByToken(request.getToken());
        if (!deviceTokens.isEmpty()) {
            pushNotificationService.sendPushNotification(request.getToken(), request.getTitle(), request.getMessage());
            return ResponseEntity.ok("Push notification sent successfully");
        } else {
            return ResponseEntity.badRequest().body("Device token not found");
        }
    }
}
