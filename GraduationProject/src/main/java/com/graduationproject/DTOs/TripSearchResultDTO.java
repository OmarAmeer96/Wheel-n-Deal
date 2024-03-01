package com.graduationproject.DTOs;

import lombok.Data;

@Data
public class TripSearchResultDTO {
    private String username;
    private String phoneNumber;
    private String from;
    private String to;
    private String CommuterProfilePhotoURL;
}