package com.graduationproject.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name="app_notifications")
public class AppNotification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @JsonBackReference
    private User user;

    private Integer orderId;

    private String message;
    // 1 - SomeOne choose you to deliver the order
    // 2 - Your order canceled
    // 3- order confirmed
    // 4- order decliend
    private Integer code;
}
