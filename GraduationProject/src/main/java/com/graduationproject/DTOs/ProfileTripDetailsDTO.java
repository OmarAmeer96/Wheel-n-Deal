package com.graduationproject.DTOs;

import lombok.Data;

@Data
public class ProfileTripDetailsDTO {
    private String from;
    private String to;
    private String day;
    private String startsAt;
    private String endsAt;
    private int capacity;
}

