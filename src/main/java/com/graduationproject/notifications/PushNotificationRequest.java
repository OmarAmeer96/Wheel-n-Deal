package com.graduationproject.notifications;

import lombok.Data;

@Data
public class PushNotificationRequest {
    private String token;
    private String title;
    private String message;
}
