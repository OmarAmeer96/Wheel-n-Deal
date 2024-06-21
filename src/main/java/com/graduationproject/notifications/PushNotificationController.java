package com.graduationproject.notifications;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("api/v1/push")
public class PushNotificationController {

    @Autowired
    private FcmService fcmService;

    @PostMapping("send")
    public void sendNotification(@RequestParam String token, @RequestParam String title, @RequestParam String body) {
        fcmService.sendNotification(token, title, body);
    }

}

