package com.graduationproject.notifications;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class DeviceToken {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String token;
}
